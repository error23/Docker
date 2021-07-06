#!/bin/bash
#############################################################
# Fichier     :  entrypoint.sh
# Auteur      :  ERROR23
# Email       :  error23.d@gmail.com
# OS          :  Linux
# Compilateur :  bash
# Date        :  04/07/2021
# Description :  Spring boot main entrypoint
#############################################################

# Source usefull commands
source /root/bin/init.conf

#
# Run all scripts in a folder $1 if any
#
function runScripts() {

	assertParamValid "$1"

	println "Running shell scripts in $1 [*]"

	local hasErrors='false'
	local filesToRun=$(find "$1" -name "*sh" | sort -n)

	for file in ${filesToRun}; do

		println "Running script $file [*]"
		chmod +x "$file"
		$file

		if [ $? -eq 0 ]; then
			println "Running script $file $successTag"
		else
			printerr "Running script $file $failTag"
			hasErrors='true'
			continue
		fi

		if [ -f "$file".export ]; then

			println "Sourcing $file.export [*]"

			#shellcheck source=file.export
			source "$file".export

			if [ $? -eq 0 ]; then
				println "Sourcing $file.export $successTag"
			else
				printerr "Sourcing $file.export $failTag"
				hasErrors='true'
			fi
		fi
	done

	if [ $hasErrors = 'true' ]; then
		printerr "Running shell scripts in $1 $failTag"
		return -1
	fi

	println "Running shell scripts in $1 $successTag"
	return 0
}

runScripts bin/preDeploy
if [ $? -ne 0 ]; then
	exit $?
fi

su postgres -c postgres-start.sh
if [ $? -ne 0 ]; then
	exit $?
fi

spring-boot-start.sh &

springBootUp='false'
trys=5

while [ $springBootUp = 'false' ]; do

	((trys--))
	sleep 5

	println "Waiting for Spring boot to start [*]"

	curl -s http://localhost:8080/actuator/health > lock
	grep 'UP' < lock

	if [ $? -eq 0 ]; then
		springBootUp='true'
		println "Waiting for Spring boot to start $successTag"
	elif [ $trys -eq 0 ]; then
		printerr "Waiting for Spring boot to start $failTag"
		rm lock
		break
	fi

	rm lock
done

runScripts bin/postDeploy

/bin/bash
