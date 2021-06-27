#!/bin/bash
#############################################################
# Fichier	  :  bcrypt.sh
# Auteur	  :  ERROR23
# Email		  :  error23.d@gmail.com
# OS		  :  Linux
# Compilateur :  bash
# Date		  :  27/06/2021
# Description :  Encrypts passwords using bcrypt algorithm
#############################################################
source init.conf

assertParamValid $1
htpasswd -nbBC 5 PASSWORD $1

