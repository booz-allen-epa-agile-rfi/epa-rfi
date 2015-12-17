#!/bin/bash
set -e
 
echo "********* RUNNING SECURITY SCAN ********"
CONTAINER_ID=$(sudo docker run -d $BACKEND_IMAGE_NAME brakeman -o brakeman-output.tabs --no-progress --separate-models);
sudo timeout 30 sudo docker wait $CONTAINER_ID || echo "Brakeman timed out!"
sudo docker logs $CONTAINER_ID
sudo docker cp $CONTAINER_ID:/usr/src/app/brakeman-output.tabs $(pwd)/reports/
sudo docker rm -f $CONTAINER_ID
 
echo "********* RUNNING STATIC CODE ANALYSIS ********"
CONTAINER_ID=$(sudo docker run -d $BACKEND_IMAGE_NAME rubocop --require rubocop/formatter/checkstyle_formatter --format RuboCop::Formatter::CheckstyleFormatter --no-color --rails --out checkstyle.xml);
sudo timeout 30 sudo docker wait $CONTAINER_ID || echo "Static code analysis timed out!"
sudo docker logs $CONTAINER_ID
sudo docker cp $CONTAINER_ID:/usr/src/app/checkstyle.xml $(pwd)/reports/
sudo docker rm -f $CONTAINER_ID
 
 
echo "********* STARTING TEST DATABASE *********"
DATABASE_ID=$(sudo docker run -d -p 5432:5432 $DATABASE_IMAGE_NAME)
IP_ADDRESS=$(sudo docker inspect --format='{{.NetworkSettings.IPAddress}}' $DATABASE_ID)
echo "IP_ADDRESS: $IP_ADDRESS"
sleep 3
 
 
echo "********* RUNNING UNIT TESTS *********"
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
 
echo "********* KILLING TEST DATABASE ********"
sudo docker rm -f $DATABASE_ID

