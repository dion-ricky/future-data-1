#! /bin/bash

sh ./download_backup.sh

docker cp backup/schema.sql postgres:/var/lib/postgresql/
docker cp backup/database.tar postgres:/var/lib/postgresql/
docker cp scripts/_exec_restore.sh postgres:/var/lib/postgresql/
docker cp scripts/_exec_backup_cleanup.sh postgres:/var/lib/postgresql/

docker exec -ti postgres bash -c "su -c /var/lib/postgresql/_exec_restore.sh postgres"
docker exec -ti postgres bash -c "su -c /var/lib/postgresql/_exec_backup_cleanup.sh root"

rm ./backup/database.tar
rm ./backup/schema.sql
