#! /bin/bash
cd /var/lib/postgresql

pg_dump -f database.tar -F t -d postgres
pg_dump -s -f schema.sql -F p -d postgres