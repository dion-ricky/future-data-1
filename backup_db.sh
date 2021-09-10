#! /bin/bash
cd "$(dirname "$0")"

docker cp scripts/_exec_backup.sh postgres:/var/lib/postgresql/
docker cp scripts/_exec_backup_cleanup.sh postgres:/var/lib/postgresql/

echo "Backup database in progress ..."
docker exec -ti postgres bash -c "su -c /var/lib/postgresql/_exec_backup.sh postgres"

echo "Copying backup database to ./backup ..."
mkdir -p backup

docker cp postgres:/var/lib/postgresql/database.tar ./backup/database.tar
docker cp postgres:/var/lib/postgresql/schema.sql ./backup/schema.sql

echo "Cleaning up ..."
docker exec -ti postgres bash -c "su -c /var/lib/postgresql/_exec_backup_cleanup.sh postgres"