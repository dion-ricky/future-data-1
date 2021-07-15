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
    "script_name": "transactional_data",
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

def extract_float(row, col):
    r = row[col]
    try:
        r = float(r)
    except Exception:
        r = 0.0
    finally:
        return r

def float_preprocess(df, cols):
    for col in cols:
        df[col] = df.apply(lambda row: extract_float(row, col), axis=1)

    return df

def int_preprocess(df, cols):
    for col in cols:
        df[col] = df.apply(lambda row: extract_int(row, col), axis=1)
    
    return df

with DAG(
    "_".join(["etl", config["script_name"]]),
    description="DAG for Transactional Data ETL",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["trx", "etl"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    wait = DummyOperator(
        task_id="wait"
    )

    trx_order = PostgreCSVOperator(
        task_id="trx_order",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_order", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "order_dataset.csv")
    )

    trx_feedback = PostgreCSVOperator(
        task_id="trx_feedback",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_feedback", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "feedback_dataset.csv"),
        preprocess=lambda _: int_preprocess(_, ["feedback_score"])
    )

    trx_payment = PostgreCSVOperator(
        task_id="trx_payment",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_payment", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "payment_dataset.csv"),
        preprocess=lambda _: int_preprocess(float_preprocess(_, [
                                                "payment_value"
                                            ]),
                                            [
                                                "payment_sequential",
                                                "payment_installments"
                                            ])
    )
    
    trx_seller = PostgreCSVOperator(
        task_id="trx_seller",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_seller", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "seller_dataset.csv")
    )
    
    trx_product = PostgreCSVOperator(
        task_id="trx_product",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_product", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "product_dataset.csv"),
        preprocess=lambda _: float_preprocess(int_preprocess(_, [
                                                "product_name_lenght",
                                                "product_description_lenght",
                                                "product_photos_qty"
                                            ]),
                                            [
                                                "product_weight_g",
                                                "product_length_cm",
                                                "product_height_cm",
                                                "product_width_cm"
                                            ])
    )
    
    trx_order_item = PostgreCSVOperator(
        task_id="trx_order_item",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_order_item", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "order_item_dataset.csv"),
        preprocess=lambda _: float_preprocess(int_preprocess(_, [
                                                    "order_item_id"
                                                ]),
                                                [
                                                    "price",
                                                    "shipping_cost"
                                                ])
    )

    trx_user = PostgreCSVOperator(
        task_id="trx_user",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_user", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "user_dataset.csv")
    )

    finish =  DummyOperator(
        task_id="finish"
    )

    start >> trx_order
    start >> trx_seller
    start >> trx_product
    start >> trx_user >> wait
    trx_order >> trx_feedback >> wait
    trx_order >> trx_order_item >> wait
    trx_order >> trx_payment >> wait
    trx_order_item << trx_seller
    trx_order_item << trx_product
    wait >> finish