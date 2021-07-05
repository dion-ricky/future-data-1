#! /bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

cd "$(dirname "$0")"
get_abs_filename() {
  # $1 : relative filename
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

mkdir ./postgresdata

POSTGRES_DATA=$(get_abs_filename './postgresdata')

docker run --name postgres \
-e POSTGRES_PASSWORD=qshOke46RvOg0 \
-e PGDATA=/var/lib/postgresql/data/pgdata \
-v "$POSTGRES_DATA":/var/lib/postgresql/data/pgdata \
-p 8084:5432 -d postgres:13