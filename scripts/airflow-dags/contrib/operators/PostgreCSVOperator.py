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
            preprocess: Callable[[pd.DataFrame], pd.DataFrame] = lambda _: _, # Callable function for data preprocessing
            **kwargs) -> None:
        super().__init__(**kwargs)
        self.conn_id = conn_id
        self.script_path = script_path
        self.csv_path = csv_path
        self.preprocess = preprocess

    def insert_csv(self):
        pg_hook = PostgresHook(
                postgres_conn_id=self.conn_id)
        conn = pg_hook.get_conn()
        cursor = conn.cursor()

        df = pd.read_csv(self.csv_path)
        df = self.preprocess(df)
        script = open(self.script_path).read()
        cols = ",".join(["%s"] * len(df.columns))

        for _, row in df.iterrows():
            row = list(row.values)
            cursor.execute(
                script.format(cols),
                row
            )
        
        conn.commit()
        return cursor.statusmessage
    
    def execute(self, context):
        return self.insert_csv()