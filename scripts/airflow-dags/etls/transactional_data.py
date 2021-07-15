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

def coalesce(df, col, replace):
    df[col] = df[col].fillna(replace)
    return df

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

    def order_preprocess(df):
        df = coalesce(df, "order_date", "1970-01-01 00:00:00")
        df = coalesce(df, "order_approved_date", "1970-01-01 00:00:00")
        df = coalesce(df, "pickup_date", "1970-01-01 00:00:00")
        df = coalesce(df, "delivered_date", "1970-01-01 00:00:00")
        df = coalesce(df, "estimated_time_delivery", "1970-01-01 00:00:00")
        return df

    trx_order = PostgreCSVOperator(
        task_id="trx_order",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_order", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "order_dataset.csv"),
        preprocess=lambda _: order_preprocess(_)
    )

    def feedback_preprocess(df):
        df = coalesce(df, "feedback_form_sent_date", "1970-01-01 00:00:00")
        df = coalesce(df, "feedback_answer_date", "1970-01-01 00:00:00")
        df = int_preprocess(df, ["feedback_score"])
        return df

    trx_feedback = PostgreCSVOperator(
        task_id="trx_feedback",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_feedback", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "feedback_dataset.csv"),
        preprocess=lambda _: feedback_preprocess(_)
    )

    def payment_preprocess(df):
        df = int_preprocess(df, ["payment_sequential", "payment_installments"])
        df = float_preprocess(df, ["payment_value"])
        return df

    trx_payment = PostgreCSVOperator(
        task_id="trx_payment",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_payment", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "payment_dataset.csv"),
        preprocess=lambda _: payment_preprocess(_)
    )
    
    trx_seller = PostgreCSVOperator(
        task_id="trx_seller",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_seller", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "seller_dataset.csv")
    )

    def product_preprocess(df):
        df = int_preprocess(df, ["product_name_lenght",
                                    "product_description_lenght",
                                    "product_photos_qty"])
        df = float_preprocess(df, ["product_weight_g",
                                    "product_length_cm",
                                    "product_height_cm",
                                    "product_width_cm"])
        return df
    
    trx_product = PostgreCSVOperator(
        task_id="trx_product",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_product", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "products_dataset.csv"),
        preprocess=lambda _: product_preprocess(_)
    )
    
    def order_item_preprocess(df):
        df = coalesce(df, "pickup_limit_date", "1970-01-01 00:00:00")
        df = int_preprocess(df, ["order_item_id"])
        df = float_preprocess(df, ["price", "shipping_cost"])
        return df

    trx_order_item = PostgreCSVOperator(
        task_id="trx_order_item",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_order_item", "sql"])),
        csv_path=os.path.join(config["local_dataset_path"],
                                    "order_item_dataset.csv"),
        preprocess=lambda _: order_item_preprocess(_)
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