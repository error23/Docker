#!/bin/bash

if [ ! -f /var/lib/pgsql/data/PG_VERSION ]; then
  echo $DB_PASSWORD >/var/lib/pgsql/pass
  initdb -D /var/lib/pgsql/data -E=UTF8 -U$DB_USER --locale=$LANG -Amd5 --pwfile=/var/lib/pgsql/pass
  rm /var/lib/pgsql/pass
  unset DB_PASSWORD
  unset DB_USER
fi

pg_ctl -D /var/lib/pgsql/data -l /var/log/postgresql start
