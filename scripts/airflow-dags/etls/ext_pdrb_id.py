import os
from datetime import timedelta

import pandas as pd
from airflow import DAG

from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago
from airflow.models import Variable

from contrib.operators.PostgreCSVOperator import PostgreCSVOperator

config = {
    "script_name": "ext_pdrb_id",
    "script_path": Variable.get("etl_script"),
    "local_dataset_path": Variable.get("ds_local_dataset"),
    "conn_id": "ds_warehouse_postgres_local"
}

def extract_int(row, col):
    r = row[col]
    try:
        r = int(r)
    except Exception:
        r = 0
    finally:
        return r

def extract_float(row, col):
    r = row[col]
    try:
        r = float(r)
    except Exception:
        r = 0.0
    finally:
        return r

def preprocess(df):
    int_cols = ["pdrb"]

    for col in int_cols:
        df[col] = df.apply(lambda row: extract_int(row, col), axis=1)
    
    return df

with DAG(
    "_".join(["etl", config["script_name"]]),
    description="DAG for External Sourced Indonesia Province PDRB ETL",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["ext", "etl"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    ext_pdrb_id = PostgreCSVOperator(
        task_id="ext_pdrb_id",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join([config["script_name"], "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "pdrb_provinsi_indonesia.csv"),
        preprocess=lambda _: preprocess(_)
    )

    finish =  DummyOperator(
        task_id="finish"
    )

    start >> ext_pdrb_id >> finish