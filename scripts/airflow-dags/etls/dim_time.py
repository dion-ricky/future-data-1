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
    "script_name": "dim_time",
    "script_path": Variable.get("etl_script"),
    "local_dataset_path": Variable.get("ds_local_dataset"),
    "conn_id": "ds_postgres_local"
}

def extract_int(row, col):
    r = row[col]
    try:
        r = int(r)
    except Exception:
        r = 0
    finally:
        return r

def extract_time(df, col):
    return df[col].dt.time

def preprocess(df):
    int_cols = ["time_id", "hour", "minute", "second"]
    datetime_cols = ["time"]
    time_cols = ["time"]

    for col in datetime_cols:
        df[col] = pd.to_datetime(df[col])

    for col in time_cols:
        df[col] = extract_time(df, col)

    for col in int_cols:
        df[col] = df.apply(lambda row: extract_int(row, col), axis=1)

    return df

with DAG(
    "_".join(["etl", config["script_name"]]),
    description="DAG for Time Dimension ETL",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["dim", "etl"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    dim_time = PostgreCSVOperator(
        task_id="dim_time",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join([config["script_name"], "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "time_dim.csv"),
        preprocess=lambda _: preprocess(_)
    )

    finish =  DummyOperator(
        task_id="finish"
    )

    start >> dim_time >> finish