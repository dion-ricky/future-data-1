import os
from datetime import timedelta

from airflow import DAG

from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago
from airflow.models import Variable

from contrib.operators.PostgreSQLOperator import PostgreSQLOperator

config = {
    "script_name": "transactional_data",
    "script_path": Variable.get("migration_script"),
    "conn_id": "ds_postgres_local"
}

with DAG(
    "_".join(["migration", config["script_name"]]),
    description="DAG for Transactional Data Migration",
    schedule_interval=None,
    start_date=days_ago(1),
    tags=["trx", "migration"]
) as dag:
    start = DummyOperator(
        task_id="start"
    )

    wait = DummyOperator(
        task_id="wait"
    )
    
    trx_order = PostgreSQLOperator(
        task_id="trx_order",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_order", "sql"]))
    )

    trx_feedback = PostgreSQLOperator(
        task_id="trx_feedback",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_feedback", "sql"]))
    )

    trx_payment = PostgreSQLOperator(
        task_id="trx_payment",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_payment", "sql"]))
    )

    trx_seller = PostgreSQLOperator(
        task_id="trx_seller",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_seller", "sql"]))
    )
    
    trx_product = PostgreSQLOperator(
        task_id="trx_product",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_product", "sql"]))
    )

    trx_order_item = PostgreSQLOperator(
        task_id="trx_order_item",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_order_item", "sql"]))
    )
    
    trx_user = PostgreSQLOperator(
        task_id="trx_user",
        conn_id=config["conn_id"],
        script_path=os.path.join(config["script_path"],
                                    ".".join(["trx_user", "sql"]))
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