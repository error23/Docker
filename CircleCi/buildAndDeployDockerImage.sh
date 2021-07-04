#!/bin/bash
#############################################################
# Fichier     :  buildAndDeployDockerImage.sh
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
figlet -c CROW DOCKER BUILDER
echo $cyanForeGround

println "Detecting git tag [*]"
if [[ -n $1 ]]; then
	CIRCLE_TAG=$1
fi

if [[ -n $CIRCLE_TAG ]]; then
	println "Git tag $CIRCLE_TAG detected $successTag"
else
	println "Git tag not detected $failTag"
	exit 0
fi

println "Detecting docker repository [*]"
if [[ -n $2 ]]; then
	DOCKER_REPOSITORY=$2
fi

if [[ -n $DOCKER_REPOSITORY ]]; then
	println "Docker repository $DOCKER_REPOSITORY detected $successTag"
else
	printerr "Docker repository not detected $failTag"
	exit -1
fi

println "Detecting docker hub user [*]"
if [[ -n $3 ]]; then
	DOCKER_REPOSITORY_USER=$3
fi

if [[ -n $DOCKER_REPOSITORY_USER ]]; then
	println "Docker hub user $DOCKER_REPOSITORY_USER detected $successTag"
else
	printerr "Docker hub user not detected $failTag"
	exit -2
fi

println "Detecting docker hub password [*]"
if [[ -n $4 ]]; then
	DOCKER_REPOSITORY_PASSWORD=$4
fi

if [[ -n $DOCKER_REPOSITORY_PASSWORD ]]; then
	println "Docker hub password $DOCKER_REPOSITORY_PASSWORD detected $successTag"
else
	printerr "Docker hub password not detected $failTag"
	exit -3
fi

println "Building release docker image $DOCKER_REPOSITORY for version $CIRCLE_TAG [*]"

docker build -t "$DOCKER_REPOSITORY":"$CIRCLE_TAG" target

if [ $? -eq 0 ]; then
	println "Building release docker image $DOCKER_REPOSITORY for version $CIRCLE_TAG $successTag"
else
	printerr "Building release docker image $DOCKER_REPOSITORY for version $CIRCLE_TAG $failTag"
	exit -4
fi

println "Login to docker hub [*]"
docker login -u "$DOCKER_REPOSITORY_USER" -p "$DOCKER_REPOSITORY_PASSWORD"

if [ $? -eq 0 ]; then
	println "Login to docker hub $successTag"
else
	printerr "Login to docker hub $failTag"
fi

println "Deploying release docker image $DOCKER_REPOSITORY for version $CIRCLE_TAG to docker hub [*]"
docker push "$DOCKER_REPOSITORY":"$CIRCLE_TAG"

if [ $? -eq 0 ]; then
	println "Deploying release docker image $DOCKER_REPOSITORY for version $CIRCLE_TAG to docker hub $successTag"
else
	printerr "Deploying release docker image $DOCKER_REPOSITORY for version $CIRCLE_TAG to docker hub $failTag"
	exit -5
fi

exit 0
