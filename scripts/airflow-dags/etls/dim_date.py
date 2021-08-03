import os
from datetime import timedelta, datetime

import pandas as pd
from airflow import DAG

from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago
from airflow.models import Variable

from contrib.operators.PostgreCSVOperator import PostgreCSVOperator

config = {
    "script_name": "dim_date",
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

def extract_bool(row, col):
    r = row[col]
    try:
        r = bool(r)
    except Exception:
        r = False
    finally:
        return r

def full_date_process(row, col):
    r = row[col]
    try:
        ts = ((r - 25569) * 86400)
        r = datetime.utcfromtimestamp(ts).strftime("%Y-%m-%d %H:%M:%S.%f%z")
    except Exception:
        raise
    finally:
        return r

def weekday_flag_process(row, col):
    r = row[col]
    try:
        r = True if r == 'Weekday' else False
    except Exception:
        r = False
    finally:
        return r

def preprocess(df):
    int_cols = ["date", "month", "quarter", "year", "day of week", "week num in year", "yearmo"]

    df['full date'] = df.apply(lambda row: full_date_process(row, 'full date'), axis=1)

    df['weekday flag'] = df.apply(lambda row: weekday_flag_process(row, 'weekday flag'), axis=1)
    
    for col in int_cols:
        df[col] = df.apply(lambda row: extract_int(row, col), axis=1)
    
    return df

with DAG(
    "_".join(["etl", config["script_name"]]),
    description="DAG for Date Dimension ETL",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["dim", "etl"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    dim_date = PostgreCSVOperator(
        task_id="dim_date",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join([config["script_name"], "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "Ch3-SampleDateDim_2014-2019.csv"),
        preprocess=lambda _: preprocess(_),
        sep=';'
    )

    finish =  DummyOperator(
        task_id="finish"
    )

    start >> dim_date >> finish