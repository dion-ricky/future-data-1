#! /bin/bash

mkdir -p backup

wget https://storage.googleapis.com/dionricky-static/schema-latest.sql -O backup/schema.sql
wget https://storage.googleapis.com/dionricky-static/database-latest.tar -O backup/database.tar