#############################################################
# Fichier     :  setMavenVersion.sh
# Auteur      :  ERROR23
# Email       :  error23.d@gmail.com
# OS          :  Linux
# Compilateur :  bash
# Date        :  07/11/2018
# Description :
#############################################################
#!/bin/bash

# Declare common script variable
# declare colors
export redForeGround="$(tput bold)$(tput setaf 1)"
export greenForeGround="$(tput bold)$(tput setaf 2)"
export cyanForeGround="$(tput bold)$(tput setaf 6)"

# Declare some other variables
export prompt="CROW >"
export successTag="$cyanForeGround[$greenForeGround OK $cyanForeGround]"
export failTag="$cyanForeGround[$redForeGround FAIL $cyanForeGround]"

echo $greenForeGround
figlet -c CROW VERSION MANAGER
echo $cyanForeGround

echo "$prompt Detecting git tag [ * ]"
if [[ -n $1 ]]; then
	CIRCLE_TAG=$1
fi

if [[ -n $CIRCLE_TAG ]]; then
	echo "$prompt Git tag $CIRCLE_TAG detected $successTag"
else
	echo "$prompt Git tag not detected $failTag"
	exit 0
fi

echo "$prompt Setting project version to $CIRCLE_TAG [ * ]"
mvn versions:set -DnewVersion=$CIRCLE_TAG

if [ $? -eq 0 ]; then
	echo "$prompt Setting project version to $CIRCLE_TAG $successTag"
else
	echo "$prompt Setting project version to $CIRCLE_TAG $failTag"
	exit -1
fi

exit 0
