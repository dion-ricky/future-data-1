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
    "script_name": "ext_provinsi_pulau",
    "script_path": Variable.get("etl_script"),
    "local_dataset_path": Variable.get("ds_local_dataset"),
    "conn_id": "ds_postgres_local"
}

def extract_int(row, col):
    r = row[col]
    try:
        r = r.replace('.', '')
        r = int(r)
    except Exception:
        r = 0
    finally:
        return r

def extract_float(row, col):
    r = row[col]
    try:
        r = r.replace('.', '')
        r = r.replace(',', '.')
        r = float(r)
    except Exception:
        r = 0.0
    finally:
        return r

def extract_province_name(row):
    r = row["Provinsi"].split(" ")
    r.pop()
    return " ".join(r)

def extract_flag_url(row):
    r = row["Provinsi"].split(" ")
    return r[-1]

def fix_dec_sep(row, col):
    r = row[col].replace('.', ',')
    return r

def preprocess(df):
    float_cols = ["Populasi(Proyeksi BPS 2020)", "Luas Total (km²)",
                "APBD 2020 (miliar rupiah)", "PDRB 2020 (triliun rupiah)",
                "PDRB per kapita 2020 (juta rupiah)",
                "IPM 2020"]

    for col in float_cols:
        df[col] = df.apply(lambda row: extract_float(row, col), axis=1)
    
    df["Flag"] = df.apply(lambda row: extract_flag_url(row), axis=1)
    df["Provinsi"] = df.apply(lambda row: extract_province_name(row), axis=1)

    return df

with DAG(
    "_".join(["etl", config["script_name"]]),
    description="DAG for External Sourced Provinsi Pulau ETL",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["ext", "etl"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    ext_provinsi_pulau = PostgreCSVOperator(
        task_id="ext_provinsi_pulau",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join([config["script_name"], "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "provinsi_pulau_indonesia.csv"),
        preprocess=lambda _: preprocess(_),
        sep=","
    )

    finish =  DummyOperator(
        task_id="finish"
    )

    start >> ext_provinsi_pulau >> finish