#! /bin/bash
cd /var/lib/postgresql

psql -f schema.sql postgres
pg_restore -c -v -d postgres database.tar
