#!/bin/bash
set -e

echo "********* STARTING TEST DATABASE *********"
DATABASE_ID=$(sudo docker run -d -p 5432:5432 $DATABASE_IMAGE_NAME)
IP_ADDRESS=$(sudo docker inspect --format='{{.NetworkSettings.IPAddress}}' $DATABASE_ID)
echo "IP_ADDRESS: $IP_ADDRESS"
sleep 10

echo "*********** RUNNING UNIT TESTS ***********"
# run minitests if they exist
if [ -d "api/test" ]
then
  CONTAINER_ID=$(sudo docker run -d --link $DATABASE_ID:db -e RAILS_ENV=docker $BACKEND_IMAGE_NAME /bin/bash run_minitest.sh);
  sudo timeout 30 sudo docker wait $CONTAINER_ID || echo 'Minitests timed out!'
  sudo docker logs $CONTAINER_ID
  sudo docker rm -f $CONTAINER_ID
fi

# run rspec unit tests if they exist
if [ -d "api/spec" ]
then
  CONTAINER_ID=$(sudo docker run -d --link $DATABASE_ID:db -e RAILS_ENV=docker $BACKEND_IMAGE_NAME /bin/bash run_rspec.sh);
  sudo timeout 30 sudo docker wait $CONTAINER_ID || echo 'RSpec tests timed out!'
  sudo docker logs $CONTAINER_ID
  sudo docker rm -f $CONTAINER_ID
fi

echo "******** RUNNING FUNCTIONAL TESTS ********"
if [ -d "api/features" ]
then
  CONTAINER_ID=$(sudo docker run -d --link $DATABASE_ID:db -e RAILS_ENV=docker $BACKEND_IMAGE_NAME cucumber);
  sudo timeout 60 sudo docker wait $CONTAINER_ID || echo 'Cucumber tests timed out!'
  sudo docker logs $CONTAINER_ID
  sudo docker rm -f $CONTAINER_ID
fi

echo "********* KILLING TEST DATABASE **********"
sudo docker rm -f $DATABASE_ID

