#!/bin/bash
#############################################################
# Fichier     :  postgresql-start.sh
# Auteur      :  ERROR23
# Email       :  error23.d@gmail.com
# OS          :  Linux
# Compilateur :  bash
# Date        :  20/06/2021
# Description :  entrypoint for postgresql docker
#############################################################

# Source usefull commands
source /root/bin/init.conf

# Print welcome message
echo $blueForeGround
figlet -c CROW POSTGRESQL STARTER
echo $cyanForeGround

# Setup .pgpass
println "Setting up postgresql local credentials for $DB_USER, $DB_PASSWORD [*]"
echo "localhost:5432:*:$DB_USER:$DB_PASSWORD" > ~/.pgpass
chmod 600 ~/.pgpass
println "Setting up postgresql local credentials for $DB_USER, $DB_PASSWORD $successTag"

# Check if database is initialized and initialize it if not
println "Checking database initialisation [*]"
if [ ! -f pgsql/data/PG_VERSION ]; then

	println "Database isn't initialized"
	println "Initialising database for $LANG locale [*]"

	echo "$DB_PASSWORD" > pgsql/password
	initdb -D pgsql/data -E=UTF8 -U"$DB_USER" --locale="$LANG" -Amd5 --pwfile=pgsql/password

	if [ $? -eq 0 ]; then
		println "Initialising database for $LANG locale $successTag"
	else
		printerr "Initialising database for $LANG locale $failTag"
		exit -1
	fi

	rm pgsql/password
else
	println "Database is already initialized"
fi
println "Checking database initialisation $successTag"

# Start database server
println "Starting postgresql server [*]"
pg_ctl -D pgsql/data -l log/postgresql.log start

if [ $? -eq 0 ]; then
	println "Starting postgresql server $successTag"
else
	printerr "Starting postgresql server $failTag"
	printerr "more informations in log/postgresql.log"
	exit -1
fi

# Create new database
println "Checking for $DB_NAME database [*]"
sqlToExecute=$(find sqlToExecute/ -maxdepth 1 -name "*.sql" | sort -V)
psql -U"$DB_USER" -dpostgres -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1

if [ $? -eq 0 ]; then
	println "Database $DB_NAME already exists"
else
	println "Database $DB_NAME doesn't exists"
	sqlToExecute=$(find sqlToExecute/ -mindepth 2 -maxdepth 2 -name "*.sql" | sort -V && find sqlToExecute/ -maxdepth 1 -name "*.sql" | sort -V)

	println "Creating database $DB_NAME for user $DB_USER with locale $LANG [*]"
	createdb -U"$DB_USER" --lc-collate="$LANG" --lc-ctype="$LANG" --template="template0" "$DB_NAME"
	if [ $? -eq 0 ]; then
		println "Creating database $DB_NAME for user $DB_USER with locale $LANG $successTag"
	else
		printerr "Creating database $DB_NAME for user $DB_USER with locale $LANG $failTag"
		exit -1
	fi
fi

println "Checking for $DB_NAME database $successTag"

#Execute all scripts in sql folder
println "Updating database [*]"
for file in $sqlToExecute; do

	println "Updating database with $file [*]"
	envsubst < "$file" > sqlToExecute/fileToExecute
	psql -d"$DB_NAME" -U"$DB_USER" < sqlToExecute/fileToExecute

	if [ $? -eq 0 ]; then
		rm sqlToExecute/fileToExecute
		println "Updating database with $file $successTag"
	else
		printerr "Updating database with $file $failTag"
		exit -1
	fi
done
println "Updating database $successTag"

# Clean up passwords
unset DB_PASSWORD
unset DB_USER
rm ~/.pgpass
