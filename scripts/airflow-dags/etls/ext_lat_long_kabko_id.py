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
    "script_name": "ext_lat_long_kabko_id",
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

def kabko_name_formatter(row, col):
    r = row[col]
    r = r.split(" ")
    if r[0] == "KAB.":
        r[0] = "KABUPATEN"
    return " ".join(r)

def preprocess(df):
    float_cols = ["lat", "long"]

    for col in float_cols:
        df[col] = df.apply(lambda row: extract_float(row, col), axis=1)
    
    df["kabko"] = df.apply(lambda row: kabko_name_formatter(row, "kabko"), axis=1)

    return df

with DAG(
    "_".join(["etl", config["script_name"]]),
    description="DAG for External Sourced Indonesia Kabupaten/Kota Latitude & Longitude ETL",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["ext", "etl"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    ext_lat_long_kabko_id = PostgreCSVOperator(
        task_id="ext_lat_long_kabko_id",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join([config["script_name"], "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "lat_long_kabko_id.csv"),
        preprocess=lambda _: preprocess(_)
    )

    finish =  DummyOperator(
        task_id="finish"
    )

    start >> ext_lat_long_kabko_id >> finish