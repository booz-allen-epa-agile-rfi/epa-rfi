#!/bin/bash
set -e

echo "************* REMOVING ALL RUNNING CONTAINERS EXCEPT THE REGISTRY ************"
sudo docker ps -a | grep -v registry | grep -v CONTAINER | awk '{print $1}' | xargs -r sudo docker rm -f || :




#!/bin/bash
set -e

echo "******************  ENTERING DOCKER-MACHINE ENVIRONMENT $DOCKER_MACHINE_NAME ******************"
eval "$(/usr/local/bin/docker-machine env $DOCKER_MACHINE_NAME)"
docker rm -f cadvisor || :




#!/bin/bash
set -e

# build frontend image
echo "***********************  BUILDING FRONTEND IMAGE $FRONTEND_IMAGE_NAME ***********************"
cd www
sudo docker build -t $FRONTEND_IMAGE_NAME .






#!/bin/bash
# set -e

# push front end to repository ($REGISTRY alias stored as jenkins global param)
echo "************************* STARTING PUSH TO REPO ****************************"
sudo docker tag -f $FRONTEND_IMAGE_NAME "$REGISTRY"/$FRONTEND_IMAGE_NAME
sudo docker push $REGISTRY/$FRONTEND_IMAGE_NAME

# deploy to the aws ec2 environment the latest front end image from repo
echo "******** ENTERING DOCKER-MACHINE ENVIRONMENT $DOCKER_MACHINE_NAME **********"
eval "$(/usr/local/bin/docker-machine env $DOCKER_MACHINE_NAME)"
if [[ -n $(docker ps | grep $FRONTEND_IMAGE_NAME) ]]; 
then 
  docker stop $FRONTEND_IMAGE_NAME
  docker rm $FRONTEND_IMAGE_NAME
fi
docker pull $REGISTRY/$FRONTEND_IMAGE_NAME:latest

echo "**************** STARTING FRONTEND SERVICE WITH $SERVE_TASK ****************"
docker run -p 9000:9000 --name $FRONTEND_IMAGE_NAME -d $REGISTRY/$FRONTEND_IMAGE_NAME grunt $SERVE_TASK

