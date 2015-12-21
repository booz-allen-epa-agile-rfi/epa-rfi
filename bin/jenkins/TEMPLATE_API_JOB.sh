##################################################################################
###                            BUILD STEP ONE                                  ###
##################################################################################

#!/bin/bash
set -e

echo "************* REMOVING ALL RUNNING CONTAINERS EXCEPT THE REGISTRY ************"
sudo docker ps -a | grep -v registry | grep -v CONTAINER | awk '{print $1}' | xargs -r sudo docker rm -f || :


##################################################################################
###                            BUILD STEP TWO                                  ###
##################################################################################


#!/bin/bash
set -e

echo "********** ENTERING DOCKER-MACHINE ENVIRONMENT $DOCKER_MACHINE_NAME **********"
eval "$(/usr/local/bin/docker-machine env $DOCKER_MACHINE_NAME)"

# remove any cadvisor or alertmanager or prometheus containers that might be running and/or stopped on $DOCKER_MACHINE_NAME
docker ps -a | grep "cadvisor\|alertmanager\|prometheus" | awk '{print $1}' | xargs -r docker rm -f || :


##################################################################################
###                           BUILD STEP THREE                                 ###
##################################################################################


#!/bin/bash
set -e

# build backend image
echo "****** BUILDING API IMAGE $BACKEND_IMAGE_NAME *********"
cd api
sudo docker build -t $BACKEND_IMAGE_NAME .

echo "******* RUNNING SECURITY SCAN OF API CODEBASE *********"
CONTAINER_ID=$(sudo docker run -d $BACKEND_IMAGE_NAME brakeman -o brakeman-output.tabs --no-progress --separate-models);
sudo timeout 30 sudo docker wait $CONTAINER_ID || echo "Brakeman timed out!"
sudo docker logs $CONTAINER_ID
sudo docker cp $CONTAINER_ID:/usr/src/app/brakeman-output.tabs $WORKSPACE/reports/
sudo docker rm -f $CONTAINER_ID

echo "**** RUNNING STATIC CODE ANALYSIS OF API CODEBASE *****"
CONTAINER_ID=$(sudo docker run -d $BACKEND_IMAGE_NAME rubocop --require rubocop/formatter/checkstyle_formatter --format RuboCop::Formatter::CheckstyleFormatter --no-color --rails --out checkstyle.xml);
sudo timeout 30 sudo docker wait $CONTAINER_ID || echo "Static code analysis timed out!"
sudo docker logs $CONTAINER_ID
sudo docker cp $CONTAINER_ID:/usr/src/app/checkstyle.xml $WORKSPACE/reports/
sudo docker rm -f $CONTAINER_ID

echo "**** BUILDING DATABASE IMAGE $DATABASE_IMAGE_NAME *****"
cd database/postgres
sudo docker build -t $DATABASE_IMAGE_NAME .


##################################################################################
###                           BUILD STEP FOUR                                  ###
##################################################################################


##################################################################################
###  JENKINS CONDITIONAL BUILD STEP RUNS TO CHECK WHETHER OR NOT TO RUN TESTS  ###
##################################################################################

# Run?: Regular expression match
# Expression: true
# Label: $RUN_TESTS
# Builder: Use builders from another project
# Template Project: TEMPLATE_API_UNIT_TESTS

##################################################################################
###                           BUILD STEP FIVE                                  ###
##################################################################################


#!/bin/bash

set -e

echo "*********PUSHING BACKEND TO REGISTRY *********"
sudo docker tag -f $BACKEND_IMAGE_NAME "$REGISTRY"/$BACKEND_IMAGE_NAME
sudo docker push "$REGISTRY"/$BACKEND_IMAGE_NAME

echo "******* PUSHING DATABASE TO REGISTRY *********"
sudo docker tag -f $DATABASE_IMAGE_NAME "$REGISTRY"/$DATABASE_IMAGE_NAME
sudo docker push "$REGISTRY"/$DATABASE_IMAGE_NAME

echo "******** BUILDING ALERTMANAGER IMAGE *********"
cd api/alertmanager
sudo docker build -t alertmanager .

echo "****** PUSHING ALERTMANAGER TO REGISTRY ******"
sudo docker tag -f alertmanager "$REGISTRY"/alertmanager
sudo docker push "$REGISTRY"/alertmanager

echo "******** BUILDING PROMETHEUS IMAGE ***********"
cd ../
cd prometheus

echo "******* GENERATING PROMETHEUS CONFIG *********"
if [ -f prometheus.yml.erb ]
then
  erb prometheus.yml.erb > prometheus.yml
fi
cat prometheus.yml

echo "****** GENERATING PROMETHEUS ALERT.RULES *****"
if [ -f alert.rules.erb ]
then
  erb alert.rules.erb > alert.rules
fi
cat alert.rules

sudo docker build -t prometheus .

echo "******* PUSHING PROMETHEUS TO REGISTRY *******"
sudo docker tag -f prometheus "$REGISTRY"/prometheus
sudo docker push "$REGISTRY"/prometheus


##################################################################################
###                            BUILD STEP SIX                                  ###
##################################################################################


#!/bin/bash

set -e

# deploy to the aws ec2 environment the latest alertmanager image
echo "***** ENTERING DOCKER-MACHINE ENVIRONMENT $DOCKER_MACHINE_NAME *******"
eval "$(/usr/local/bin/docker-machine env $DOCKER_MACHINE_NAME)"

echo "********* PULLING ALERTMANAGER CONTAINER TO AWS INSTANCE *************"
docker pull $REGISTRY/alertmanager:latest

cd api/alertmanager/

echo "******************* RUNNING ALERTMANAGER CONTAINER *******************"
ALERTMANAGER_ID=$(docker run -d -p 9093:9093 --name alertmanager -d $REGISTRY/alertmanager -config.file=/alertmanager/alertmanager.conf)
ALERTMANAGER_IP=$(docker inspect --format='{{.NetworkSettings.IPAddress}}' $ALERTMANAGER_ID)

echo "*** PULLING PROMETHEUS CONTAINER TO $DOCKER_MACHINE_NAME INSTANCE ****"
docker pull $REGISTRY/prometheus:latest

cd ../prometheus/

echo "******************** RUNNING PROMETHEUS CONTAINER ********************"
docker run -d -p 9090:9090 --name prometheus -d $REGISTRY/prometheus -config.file=/etc/prometheus/prometheus.yml -alertmanager.url=http://$ALERTMANAGER_IP:9093 -log.level=debug
  
cd ../
  
echo "******************* GENERATING DOCKER COMPOSE FILE *******************"
if [ -f docker-compose.yml.erb ]
then
  erb docker-compose.yml.erb > docker-compose.yml
fi
cat docker-compose.yml

echo "********** USING DOCKER-COMPOSE TO RESTART BACKEND SERVICES **********"
docker-compose stop || :
docker-compose pull
docker-compose up -d
echo "**********************  DOCKER-COMPOSE FINISHED **********************"


##################################################################################
###                            BUILD STEP SEVEN                                ###
##################################################################################


##################################################################################
###                  TRIGGER/CALL BUILDS ON OTHER PROJECTS                     ###
##################################################################################

# Projects to build: TEMPLATE_CLEANUP_OLD_IMAGES 
# Predefined parameters: DOCKER_MACHINE_NAME=$DOCKER_MACHINE_NAME
