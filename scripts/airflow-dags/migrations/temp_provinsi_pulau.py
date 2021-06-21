import os
from datetime import timedelta

from airflow import DAG

from airflow.providers.postgres.hooks.postgres import PostgresHook

from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from airflow.models import Variable

import pandas as pd

from contrib.operators.PostgreSQLOperator import PostgreSQLOperator

config = {
    "script_name": "temp_provinsi_pulau",
    "script_path": Variable.get("migration_script"),
    "conn_id": "ds_warehouse_postgres_local"
}


def extract_province_name(row):
    r = row["Provinsi"].split(" ")
    r.pop()
    return " ".join(r)

def extract_flag_url(row):
    r = row["Provinsi"].split(" ")
    return r[-1]

def insert_provinsi_pulau():
    pg_hook = PostgresHook(
            postgres_conn_id=config["conn_id"])
    conn = pg_hook.get_conn()
    cursor = conn.cursor()

    df = pd.read_csv('/home/dion-ricky/future/PROJECT/scripts/local_datasets/provinsi_pulau_indonesia.csv')
    df["Flag"] = df.apply(lambda row: extract_flag_url(row), axis=1)
    df["Provinsi"] = df.apply(lambda row: extract_province_name(row), axis=1)

    for _, row in df.iterrows():
        row = list(row.values)
        cursor.execute(
            "INSERT INTO temp_provinsi_pulau VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
            row
        )
    
    conn.commit()
    return cursor.statusmessage


with DAG(
    "_".join(["migration", config["script_name"]]),
    description="DAG for Temporary Provinsi Pulau Migration",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["temp", "migration"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    # create temp table isinya data provinsi_pulau_indonesia
    # extract data dari csv provinsi_pulau_indonesia
    # modify fact seller state, join dengan data pulau

    temp_provinsi_pulau = PostgreSQLOperator(
        task_id="temp_provinsi_pulau",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join([config["script_name"], "sql"]))
    )

    # pythonoperator
    insert_provinsi_pulau = PythonOperator(
        task_id="insert_provinsi_pulau",
        python_callable=insert_provinsi_pulau
    )

    finish =  DummyOperator(
        task_id="finish"
    )

    start >> temp_provinsi_pulau >> insert_provinsi_pulau >> finish
