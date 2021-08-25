#! /bin/bash

wget https://storage.googleapis.com/dionricky-static/schema-latest.sql -O schema.sql
wget https://storage.googleapis.com/dionricky-static/database-latest.tar -O database.tar

docker cp schema.sql postgres:/var/lib/postgresql/
docker cp database.tar postgres:/var/lib/postgresql/
docker cp _exec_restore.sh postgres:/var/lib/postgresql/

docker exec -ti postgres bash -c "su -c /var/lib/postgresql/_exec_restore.sh postgres"

rm ./database.tar
rm ./schema.sql
