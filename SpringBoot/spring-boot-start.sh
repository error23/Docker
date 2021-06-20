#############################################################
# Fichier     :  spring-boot-start.sh
# Auteur      :  ERROR23
# Email       :  error23.d@gmail.com
# OS          :  Linux
# Compilateur :  bash
# Date        :  20/06/2021
# Description :  entrypoint for spring-boot docker
#############################################################
#!/bin/bash

java -jar $JAVA_ARGS /bin/*jar $SPRING_ARGS | tee -a log/spring-booot.log
