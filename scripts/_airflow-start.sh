#! /bin/bash
cd "$(dirname "$0")"

# start the web server, default port is 8080

# start the scheduler
# open a new terminal or else run webserver with ``-D`` option to run it as a daemon
source ../env/bin/activate
airflow webserver --port 8080 & airflow scheduler