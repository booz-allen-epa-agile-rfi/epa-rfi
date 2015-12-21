# This will download and install docker-machine on linux.
#curl -L https://github.com/docker/machine/releases/download/v0.5.4/docker-machine_linux-amd64 > /usr/local/bin/docker-machine && chmod +x /usr/local/bin/docker-machine
# Or, install with wget
wget https://github.com/docker/machine/releases/download/v0.5.4/docker-machine_linux-amd64 -O docker-machine
chmod +x docker-machine
sudo mv docker-machine /usr/local/bin/docker-machine
