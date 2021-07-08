#! /bin/bash
cd "${dirname $0}"

source ../env/bin/activate
screen -S jupyter jupyter-lab --ip=0.0.0.0 --port 838$((RANDOM % 10))
