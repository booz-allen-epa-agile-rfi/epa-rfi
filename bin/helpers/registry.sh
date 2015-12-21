# This will run a private docker registry and store images in /var/lib/registry

# If the /var/lib/registry directory doesn't exist, then create it
if [ ! -d /var/lib/registry ]; then
    sudo mkdir -p /var/lib/registry
fi

# Run docker registry 
docker run -d -p 5000:5000  -v /var/lib/registry:/tmp/registry/repositories/library --restart=always --name registry registry:2
