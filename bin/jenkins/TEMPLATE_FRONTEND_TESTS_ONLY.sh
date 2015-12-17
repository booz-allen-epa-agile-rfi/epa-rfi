#!/bin/bash
set -e

# Run frontend unit and integration tests locally (i.e. before pushing)
echo '*********************** EXECUTING GRUNT TEST *************************'
CONTAINER_ID=$(sudo docker run -e "BROWSER=phantomjs" -d $FRONTEND_IMAGE_NAME grunt test);
sudo timeout 60 sudo docker wait $CONTAINER_ID || echo 'grunt test timed out!'
sudo docker cp $CONTAINER_ID:/usr/src/app/client/tests /home/jenkins/epa-rfi/reports/
sudo docker logs $CONTAINER_ID
sudo docker rm -f $CONTAINER_ID
echo '*********************** GRUNT TEST COMPLETED *************************'

