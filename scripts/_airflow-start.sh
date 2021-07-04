#! /bin/bash
cd "$(dirname "$0")"

source ../env/bin/activate
airflow webserver --port 8080 & airflow scheduler