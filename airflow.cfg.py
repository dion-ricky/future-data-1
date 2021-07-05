import os
import subprocess
import json

def load_json(file):
    with open(file, 'r') as _f:
        while(_f.readline().strip() != 'START'):
            continue
        
        return json.load(_f)

AIRFLOW_VAR = load_json('airflow.var.cfg')

AIRFLOW_VAR["do_not_edit_this_file"] = "WARNING!! Do not edit this file directly, instead use airflow.var.config.json and rerun setup.sh"

AIRFLOW_VAR["ds_local_dataset"] = os.path.abspath(AIRFLOW_VAR["ds_local_dataset"])
AIRFLOW_VAR["etl_script"] = os.path.abspath(AIRFLOW_VAR["etl_script"])
AIRFLOW_VAR["future_data_1_dag_path"] = os.path.abspath(AIRFLOW_VAR["future_data_1_dag_path"])
AIRFLOW_VAR["migration_script"] = os.path.abspath(AIRFLOW_VAR["migration_script"])

with open('airflow.var.json', 'w') as _f:
    _f.write(
        json.dumps(AIRFLOW_VAR, indent = 4)
    )

AIRFLOW_CONN = load_json('airflow.conn.cfg')

for key in AIRFLOW_CONN:
    connection = AIRFLOW_CONN[key]
    
    # call airflow using subprocess
    subprocess.run([
        "airflow",
        "connections",
        "add",
        "--conn-description",
        connection["description"],
        "--conn-host",
        connection["host"],
        "--conn-login",
        connection["login"],
        "--conn-password",
        connection["password"],
        "--conn-port",
        connection["port"],
        "--conn-schema",
        connection["schema"],
        "--conn-type",
        connection["conn_type"],
        key
    ])