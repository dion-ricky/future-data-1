import os
from datetime import timedelta

from airflow import DAG

from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago
from airflow.models import Variable

from contrib.operators.PostgreSQLOperator import PostgreSQLOperator

config = {
    "script_name": "ext_indonesia_geoprops",
    "script_path": Variable.get("migration_script"),
    "conn_id": "ds_postgres_local"
}

with DAG(
    "_".join(["migration", config["script_name"]]),
    description="DAG for Temp Indonesia Geoprops Migration",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["ext", "migration"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    ext_indonesia_geoprops = PostgreSQLOperator(
        task_id="ext_indonesia_geoprops",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join([config["script_name"], "sql"]))
    )

    finish =  DummyOperator(
        task_id="finish"
    )

    start >> ext_indonesia_geoprops  >> finish