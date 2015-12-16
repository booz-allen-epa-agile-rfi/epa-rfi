echo "********************** CLEANING IMAGES MARKED AS <none> **********************"
sudo docker images --no-trunc | grep "<none>" | awk '{print $3}' | xargs -r sudo docker rmi -f || :

echo "*********************** CLEANING $DOCKER_MACHINE_NAME ************************"
eval "$(/usr/local/bin/docker-machine env $DOCKER_MACHINE_NAME)"
docker images --no-trunc | grep "<none>" | awk '{print $3}' | xargs -r docker rmi -f || :

echo "************************ RUNNING CADVISOR CONTAINER **************************"
docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  google/cadvisor:latest

