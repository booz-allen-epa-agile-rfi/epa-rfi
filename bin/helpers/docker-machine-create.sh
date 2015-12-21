#!/bin/bash

# First you must su to the jenkins user so it will have access to the keys
sudo su - jenkins

# Fillin the below variables with the relevant values
DRIVER=amazonec2;
AWS_ACCESS_KEY_ID=AKAI----------------
AWS_SECRET_ACCESS_KEY=IRX--------------------------------------
AWS_VPC_ID=vpc-20171h
AWS_REGION=us-west-2
AWS_ZONE=c
AWS_INSTANCE_TYPE=t2.medium
AWS_ROOT_SIZE=32
REGISTRY=registry.domain.com:5000 # or IP:5000
EC2_INSTANCE_NAME=development # staging or master

# Create the EC2 instance and generate all the necessary keys and stuff
docker-machine create \
--debug \
-d $DRIVER \
--amazonec2-access-key $AWS_ACCESS_KEY_ID \
--amazonec2-secret-key $AWS_SECRET_ACCESS_KEY \
--amazonec2-vpc-id $AWS_VPC_ID \
--amazonec2-region $AWS_REGION \
--amazonec2-zone $AWS_ZONE \
--amazonec2-instance-type $AWS_INSTANCE_TYPE \
--amazonec2-root-size $AWS_ROOT_SIZE \
--engine-insecure-registry $REGISTRY \
--amazonec2-use-private-addres \ 
$EC2_INSTANCE_NAME
