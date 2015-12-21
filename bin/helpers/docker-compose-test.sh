#!/bin/bash

DIRECTORY="../../api"
MACHINE_NAME="development" # staging or master


cd $DIRECTORY
# deploy to the aws ec2 environment the latest front end image from repo
echo "************ ENTERING AWS DOCKER CLIENT ENVIRONMENT *************"
eval "$(/usr/local/bin/docker-machine env $MACHINE_NAME)"

if [ -f docker-compose.yml.erb ]
then
  erb docker-compose.yml.erb > docker-compose.yml
fi
cat docker-compose.yml
echo "*********** USING DOCKER-COMPOSE TO RESTART SERVICES ************"
docker-compose stop || :
docker-compose pull
docker-compose up -d
echo "******************** DOCKER-COMPOSE FINISHED ********************"

