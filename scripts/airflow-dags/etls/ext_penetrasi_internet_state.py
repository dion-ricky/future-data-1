import os
from datetime import timedelta

from airflow import DAG

from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago
from airflow.models import Variable

from contrib.operators.PostgreCSVOperator import PostgreCSVOperator

config = {
    "script_name": "ext_penetrasi_internet_state",
    "script_path": Variable.get("etl_script"),
    "local_dataset_path": Variable.get("ds_local_dataset"),
    "conn_id": "ds_warehouse_postgres_local"
}

with DAG(
    "_".join(["etl", config["script_name"]]),
    description="DAG for External Sourced Penetrasi Internet State ETL",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["ext", "etl"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    ext_penetrasi_internet_state = PostgreCSVOperator(
        task_id="ext_penetrasi_internet_state",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join([config["script_name"], "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "kontribusi_penetrasi_internet_state.csv")
    )

    finish =  DummyOperator(
        task_id="finish"
    )

    start >> ext_penetrasi_internet_state >> finish