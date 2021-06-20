#############################################################
# Fichier     :  postgresql-start.sh
# Auteur      :  ERROR23
# Email       :  error23.d@gmail.com
# OS          :  Linux
# Compilateur :  bash
# Date        :  20/06/2021
# Description :  entrypoint for postgresql docker
#############################################################
#!/bin/bash

echo "localhost:5432:*:$DB_USER:$DB_PASSWORD" > ~/.pgpass
chmod 600 ~/.pgpass

if [ ! -f pgsql/data/PG_VERSION ]; then
	echo $DB_PASSWORD > pgsql/password
	initdb -D pgsql/data -E=UTF8 -U$DB_USER --locale=$LANG -Amd5 --pwfile=pgsql/password
	rm pgsql/password
fi

pg_ctl -D pgsql/data -l log/postgresql start

createdb -U$DB_USER --lc-collate=$LANG --lc-ctype=$LANG --template="template0" $DB_NAME

for file in $(ls sql/ | sort); do
	psql -d$DB_NAME -U$DB_USER < sql/$file
done

# clean up passwords
unset DB_PASSWORD
unset DB_USER
rm ~/.pgpass
