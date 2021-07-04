#! /bin/bash
cd "$(dirname "$0")"
get_abs_filename() {
  # $1 : relative filename
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

export AIRFLOW_HOME=$(get_abs_filename "../airflow")

source ../env/bin/activate
airflow webserver --port 8080 & airflow scheduler