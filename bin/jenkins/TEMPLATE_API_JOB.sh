#!/bin/bash
set -e

echo "************* REMOVING ALL RUNNING CONTAINERS EXCEPT THE REGISTRY ************"
sudo docker ps -a | grep -v registry | grep -v CONTAINER | awk '{print $1}' | xargs -r sudo docker rm -f || :





#!/bin/bash
set -e

echo "********* ENTERING DOCKER-MACHINE ENVIRONMENT $DOCKER_MACHINE_NAME ********"
eval "$(/usr/local/bin/docker-machine env $DOCKER_MACHINE_NAME)"
docker rm -f cadvisor || :






#!/bin/bash
set -e

# build backend image
echo "************** BUILDING API IMAGE $BACKEND_IMAGE_NAME *************"
cd api
sudo docker build -t $BACKEND_IMAGE_NAME .

echo "********** BUILDING DATABASE IMAGE $DATABASE_IMAGE_NAME ***********"
cd ..
cd api/database/postgres
sudo docker build -t $DATABASE_IMAGE_NAME .

# push to repo
echo "***************** STARTING PUSH TO DOCKER REGISTRY ****************"
sudo docker tag -f $BACKEND_IMAGE_NAME "$REGISTRY"/$BACKEND_IMAGE_NAME
sudo docker push "$REGISTRY"/$BACKEND_IMAGE_NAME
sudo docker tag -f $DATABASE_IMAGE_NAME "$REGISTRY"/$DATABASE_IMAGE_NAME
sudo docker push "$REGISTRY"/$DATABASE_IMAGE_NAME
echo "***************** FINISHED PUSH TO DOCKER REGISTRY ****************"






#!/bin/bash

set -e

cd api

# deploy to the aws ec2 environment the latest api image from repo
echo "********* ENTERING DOCKER-MACHINE ENVIRONMENT $DOCKER_MACHINE_NAME ********"
eval "$(/usr/local/bin/docker-machine env $DOCKER_MACHINE_NAME)"

echo "******************* GENERATING DOCKER COMPOSE FILE *******************"
if [ -f docker-compose.yml.erb ]
then
  erb docker-compose.yml.erb > docker-compose.yml
fi

echo "********** USING DOCKER-COMPOSE TO RESTART BACKEND SERVICES **********"
docker-compose stop || :
docker-compose pull --allow-insecure-ssl
docker-compose up -d --allow-insecure-ssl
echo "**********************  DOCKER-COMPOSE FINISHED **********************"

