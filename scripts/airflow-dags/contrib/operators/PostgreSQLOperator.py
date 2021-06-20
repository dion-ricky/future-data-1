from airflow.models.baseoperator import BaseOperator

from airflow.providers.postgres.hooks.postgres import PostgresHook

class PostgreSQLOperator(BaseOperator):

    def __init__(
            self,
            conn_id: str, # Airflow backend connection id
            script_path: str, # Path to SQL script
            **kwargs) -> None:
        super().__init__(**kwargs)
        self.conn_id = conn_id
        self.script = open(script_path, 'r').read()
    
    def execute(self, context):
        pg_hook = PostgresHook(
                postgres_conn_id=self.conn_id)
        conn = pg_hook.get_conn()
        cursor = conn.cursor()
        cursor.execute(self.script)
        conn.commit()
        print(cursor.statusmessage)
        return cursor.statusmessage