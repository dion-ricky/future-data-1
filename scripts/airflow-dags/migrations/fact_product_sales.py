import os
from datetime import timedelta

from airflow import DAG

from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago
from airflow.models import Variable

from contrib.operators.PostgreSQLOperator import PostgreSQLOperator

config = {
    "dag_id": "fact_product_sales",
    "migration_script_path": Variable.get("migration_script"),
    "conn_id": "ds_warehouse_postgres_local"
}

with DAG(
    config["dag_id"],
    description="DAG for Product Sales Fact Migration",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["fact", "migration"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    fact_product_sales = PostgreSQLOperator(
        task_id="fact_product_sales",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["migration_script_path"],
                                    ".".join([config["dag_id"], "sql"]))
    )

    finish =  DummyOperator(
        task_id="finish"
    )

    start >> fact_product_sales >> finish