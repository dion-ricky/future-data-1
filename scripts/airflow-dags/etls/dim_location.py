import os
from datetime import timedelta

from airflow import DAG

from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago
from airflow.models import Variable

from contrib.operators.PostgreSQLOperator import PostgreSQLOperator

config = {
    "script_name": "dim_location",
    "script_path": Variable.get("etl_script"),
    "conn_id": "ds_postgres_local"
}

with DAG(
    "_".join(["etl", config["script_name"]]),
    description="DAG for Location Dimension ETL",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["dim", "etl"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    dim_location = PostgreSQLOperator(
        task_id="dim_location",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join([config["script_name"], "sql"]))
    )

    finish =  DummyOperator(
        task_id="finish"
    )

    start >> dim_location >> finish