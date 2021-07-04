#! /bin/bash
cd "$(dirname "$0")"
export AIRFLOW_HOME=../airflow

source ../env/bin/activate
airflow webserver --port 8080 & airflow scheduler