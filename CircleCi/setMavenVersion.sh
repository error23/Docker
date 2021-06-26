#!/bin/bash
#############################################################
# Fichier     :  setMavenVersion.sh
# Auteur      :  ERROR23
# Email       :  error23.d@gmail.com
# OS          :  Linux
# Compilateur :  bash
# Date        :  07/11/2018
# Description :
#############################################################

# Source usefull commands
source /root/bin/init.conf

# Print welcome message
echo $blueForeGround
figlet -c CROW VERSION MANAGER
echo $cyanForeGround

println 'Detecting git tag [*]'
if [[ -n $1 ]]; then
	CIRCLE_TAG=$1
fi

if [[ -n $CIRCLE_TAG ]]; then
	println "Git tag $CIRCLE_TAG detected $successTag"
else
	printerr "Git tag not detected $failTag"
	exit 0
fi

println "Setting project version to $CIRCLE_TAG [*]"
mvn versions:set -DnewVersion="$CIRCLE_TAG"

if [ $? -eq 0 ]; then
	println "Setting project version to $CIRCLE_TAG $successTag"
else
	printerr "Setting project version to $CIRCLE_TAG $failTag"
	exit -1
fi

exit 0
