#!/bin/bash
#############################################################
# Fichier     :  spring-boot-start.sh
# Auteur      :  ERROR23
# Email       :  error23.d@gmail.com
# OS          :  Linux
# Compilateur :  bash
# Date        :  20/06/2021
# Description :  entrypoint for spring-boot docker
#############################################################
# Source usefull commands
source /root/bin/init.conf

# Print welcome message
echo $blueForeGround
figlet -c CROW SPRING BOOT STARTER
echo $cyanForeGround

if [ -f bin/$SPRING_EXECUTABLE_JAR ]; then
	println "Running : ${blueForeGround}java -jar $JAVA_ARGS bin/$SPRING_EXECUTABLE_JAR $SPRING_ARGS | tee -a log/spring-booot.log $cyanForeGround"
	java -jar $JAVA_ARGS bin/$SPRING_EXECUTABLE_JAR $SPRING_ARGS | tee -a log/spring-booot.log
else
	printerr "Spring executable jar not $SPRING_EXECUTABLE_JAR not found there is nothig to execute."
	exit -1
fi
