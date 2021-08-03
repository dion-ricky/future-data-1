from typing import Callable

import pandas as pd

from airflow.models.baseoperator import BaseOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook

class PostgreCSVOperator(BaseOperator):

    def __init__(
            self,
            conn_id: str, # Airflow backend connection id
            script_path: str, # Path to INSERT script
            csv_path: str, # Path to CSV file
            batch_size: int = 10000, # Number of query before committed
            preprocess: Callable[[pd.DataFrame], pd.DataFrame] = lambda _: _, # Callable function for data preprocessing
            sep: str = ',', # Pandas read_csv separator
            **kwargs) -> None:
        super().__init__(**kwargs)
        self.conn_id = conn_id
        self.script_path = script_path
        self.csv_path = csv_path
        self.batch_size = batch_size
        self.preprocess = preprocess
        self.sep = sep

    def insert_csv(self):
        pg_hook = PostgresHook(
                postgres_conn_id=self.conn_id)
        conn = pg_hook.get_conn()
        cursor = conn.cursor()

        df = pd.read_csv(self.csv_path, sep=self.sep)
        df = self.preprocess(df)
        script = open(self.script_path).read()
        cols = ",".join(["%s"] * len(df.columns))

        counter = 0

        for _, row in df.iterrows():
            # Increment counter, need to know when to commit
            counter = counter + 1

            row = list(row.values)
            cursor.execute(
                script.format(cols),
                row
            )

            if counter == self.batch_size:
                conn.commit()
                counter = 0
        
        conn.commit()
        return cursor.statusmessage
    
    def execute(self, context):
        return self.insert_csv()