#! /bin/bash
cd "$(dirname "$0")"

migration="migration_"
etl="etl_"

dag="transactional_data"

airflow dags unpause "$migration$dag"
airflow dags trigger "$migration$dag"