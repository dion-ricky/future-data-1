import os
import sys

file_dir = os.path.dirname(__file__)
sys.path.append(file_dir)

from datetime import timedelta

from airflow import DAG

# Operators; we need this to operate!
from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago
from airflow.models import Variable

from contrib.operators.HelloOperator import HelloOperator
from contrib.operators.PostgreSQLOperator import PostgreSQLOperator

config = {
    "migration_script_path": Variable.get("migration_script"),
    "conn_id": "ds_warehouse_postgres_local"
}

with DAG(
    "test_dag",
    description="Test DAG",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["tutorial"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    t1 = BashOperator(
        task_id="bash_t1",
        bash_command="echo t1 executed"
    )

    t2 = HelloOperator(
        task_id="hello_t2",
        name="Task 2"
    )

    t3 = PostgreSQLOperator(
        task_id="psql_t3",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["migration_script_path"],
                                    "fact_product_sales.sql")
    )

    finish =  DummyOperator(
        task_id="finish"
    )

    start >> t1 >> t2 >> t3 >> finish