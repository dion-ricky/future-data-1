#! /bin/bash
cd "$(dirname "$0")"

get_abs_filename() {
  # $1 : relative filename
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

get_py_ver() {
    echo "$(cat ./env/pyvenv.cfg | grep 'version' | cut -d = -f 2 | sed 's#.* \([0-9].[0-9]\).*#\1#')"
}

timestamp() {
  date +"%Y-%m-%d %H:%M:%S" # current time
}

log () {
    echo "[$(timestamp)] $1: $2"
}

log_debug () {
    log "DEBUG" "$1"
}

log_error() {
    echo "$(log "ERROR" "$1")" >&2
}

die() {
    log_error "$1"
    exit 1
}

cmd_exists () {
    log_debug "Check if $1 is available"
    command -v "$1" >/dev/null 2>&1
}

check_deps () {
    if ! cmd_exists python3; then
        die 'python3 is not installed.'
    fi
    if ! cmd_exists docker; then
        die 'docker is not installed.'
    fi
}

create_python_venv () {
    log_debug "Creating python virtual env"
    {
        FILE=./env/pyvenv.cfg
        if test -f "$FILE"; then
            if [[ $(cat ./env/pyvenv.cfg | grep 'version' | cut -d = -f 2 | cut -d . -f 1) = *3* ]]; then
                return 0
            fi
        fi
        python3 -m venv env
    } || {
        die 'Failed to create python virtual env'
    }
}

install_python_deps () {
    log_debug "Installing python dependencies from requirements.txt"
    {
        FILE=./requirements.txt
        if test -f "$FILE"; then
            source ./env/bin/activate
            pip install wheel
            pip install psycopg2-binary
            pip install -Ur requirements.txt
            deactivate
        else
            die 'requirements.txt does not exists'
        fi
    } || {
        die 'Failed to install python requirements'
    }
}

airflow_postinstall_config () {
    # create symlink of contrib and dags folder
    source ./env/bin/activate
    if ! cmd_exists airflow; then
        die 'airflow is not installed; check for airflow installation'
    fi

    log_debug "Creating symlink for contrib and DAG folder"
    mkdir -p airflow/dags

    DAG_FOLDER=$(get_abs_filename "./scripts/airflow-dags")
    ln -s "$DAG_FOLDER" ./airflow/dags/future-project-1
    
    CONTRIB=$(get_abs_filename "./scripts/airflow-dags/contrib")
    PV=$(get_py_ver)
    ln -s "$CONTRIB" "./env/lib/python$PV/site-packages/contrib"

    log_debug "Configuring Airflow variables and connections"
    python3 airflow.cfg.py

    # Do not edit airflow.var.json directly, use airflow.var.cfg instead
    airflow variables import airflow.var.json
    airflow variables delete do_not_edit_this_file

    # End of airflow var and conn configuration
    deactivate
}

airflow_setup () {
    log_debug "Installing and configuring airflow"
    {
        bash ./scripts/_airflow-setup.sh
    } || {
        die 'Failed to install airflow'
    }
    log_debug "Airflow installation success"
    airflow_postinstall_config
}

check_deps && \
create_python_venv && \
install_python_deps &&  \
airflow_setup && \
log_debug "Done."