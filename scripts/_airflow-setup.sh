#! /bin/bash
cd "$(dirname "$0")"
source ../env/bin/activate

get_abs_filename() {
  # $1 : relative filename
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

# airflow needs a home, ~/airflow is the default,
# but you can lay foundation somewhere else if you prefer
# (optional)
export AIRFLOW_HOME=$(get_abs_filename "../../airflow")

AIRFLOW_VERSION=2.1.0
PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
# For example: 3.6
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
# For example: https://raw.githubusercontent.com/apache/airflow/constraints-2.1.0/constraints-3.6.txt
pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

# initialize the database
export AIRFLOW__CORE__LOAD_EXAMPLES=False # Init airflow without example dags
airflow db init

airflow users create \
    --username admin \
    --password airflowadmin \
    --firstname Dion \
    --lastname Ricky \
    --role Admin \
    --email dion@dionricky.com

deactivate