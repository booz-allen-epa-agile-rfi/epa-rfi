#!/bin/bash

set -e

echo "********************** CLEANING IMAGES MARKED AS <none> **********************"
sudo docker images --no-trunc | grep "<none>" | awk '{print $3}' | xargs -r sudo docker rmi -f || :

echo "*********************** CLEANING $DOCKER_MACHINE_NAME ************************"
eval "$(/usr/local/bin/docker-machine env $DOCKER_MACHINE_NAME)"
docker images --no-trunc | grep "<none>" | awk '{print $3}' | xargs -r docker rmi -f || :

