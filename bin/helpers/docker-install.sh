# Set the username to your current user
USERNAME=vagrant

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# This is the repo for Ubuntu 14.04
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > docker.list
sudo mv docker.list /etc/apt/sources.list.d/

sudo apt-get update
sudo apt-get purge lxc-docker
sudo apt-cache policy docker-engine
sudo apt-get install linux-image-extra-$(uname -r)
sudo apt-get install docker-engine
sudo service docker start
sudo usermod -aG docker $USERNAME
docker --version
