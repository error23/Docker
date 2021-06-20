#!/bin/bash

if [ ! -f pgsql/data/PG_VERSION ]; then
  echo $DB_PASSWORD >pgsql/pass
  initdb -D pgsql/data -E=UTF8 -U$DB_USER --locale=$DB_LOCALE -Amd5 --pwfile=pgsql/pass
  rm pgsql/pass
  unset DB_PASSWORD
  unset DB_USER
fi

pg_ctl -D pgsql/data -l log/postgresql start
