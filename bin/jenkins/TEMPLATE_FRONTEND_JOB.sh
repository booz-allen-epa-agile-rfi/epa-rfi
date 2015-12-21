##################################################################################
###                            BUILD STEP ONE                                  ###
##################################################################################


#!/bin/bash
set -e

echo "**** REMOVING ALL RUNNING CONTAINERS EXCEPT THE REGISTRY ****"
sudo docker ps -a | grep -v registry | grep -v CONTAINER | awk '{print $1}' | xargs -r sudo docker rm -f || :


##################################################################################
###                            BUILD STEP TWO                                  ###
##################################################################################


#!/bin/bash
set -e

# build frontend image
echo "******** BUILDING FRONTEND IMAGE $FRONTEND_IMAGE_NAME *******"
cd www
sudo docker build -t $FRONTEND_IMAGE_NAME .


##################################################################################
###                           BUILD STEP THREE                                 ###
##################################################################################

##################################################################################
###  JENKINS CONDITIONAL BUILD STEP RUNS TO CHECK WHETHER OR NOT TO RUN TESTS  ###
##################################################################################

# Run?: Regular expression match
# Expression: true
# Label: $RUN_TESTS
# Builder: Use builders from another project
# Template Project: TEMPLATE_FRONTEND_UNIT_TESTS

##################################################################################
###                           BUILD STEP FOUR                                  ###
##################################################################################


#!/bin/bash

set -e

# push frontend to registry ($REGISTRY stored as jenkins global)
echo "*************** STARTING PUSH TO REPO ***************"
sudo docker tag -f $FRONTEND_IMAGE_NAME "$REGISTRY"/$FRONTEND_IMAGE_NAME
sudo docker push $REGISTRY/$FRONTEND_IMAGE_NAME

# deploy to the aws ec2 environment the latest front end image from repo
echo "** ENTERING DOCKER-MACHINE ENVIRONMENT $DOCKER_MACHINE_NAME **"
eval "$(/usr/local/bin/docker-machine env $DOCKER_MACHINE_NAME)"

# remove any frontend containers that might be running and/or stopped on $DOCKER_MACHINE_NAME
docker ps -a | grep $FRONTEND_IMAGE_NAME | awk '{print $1}' | xargs -r docker rm -f || :

docker pull $REGISTRY/$FRONTEND_IMAGE_NAME:latest

echo "**** STARTING FRONTEND SERVICE WITH $SERVE_TASK *****"
docker run -p 80:9000 --name $FRONTEND_IMAGE_NAME -d $REGISTRY/$FRONTEND_IMAGE_NAME


##################################################################################
###                             BUILD STEP FIVE                                ###
##################################################################################


##################################################################################
###                  TRIGGER/CALL BUILDS ON OTHER PROJECTS                     ###
##################################################################################

# Projects to build: TEMPLATE_CLEANUP_OLD_IMAGES 
# Predefined parameters: DOCKER_MACHINE_NAME=$DOCKER_MACHINE_NAME

