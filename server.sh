#!/bin/bash 
cd server 

#!/bin/bash

# Define variables
DOCKERFILE="Dockerfile"
IMAGE_NAME="custom-wireguard"
COMPOSE_OVERRIDE="docker-compose.override.yml"

# Step 1: Create the Dockerfile
echo "Creating Dockerfile..."
cat <<EOF > $DOCKERFILE
FROM linuxserver/wireguard
RUN apk add --no-cache iptables-nft
EOF

# Step 2: Build the custom Docker image
echo "Building custom Docker image: $IMAGE_NAME..."
docker build -t $IMAGE_NAME .

# Step 3: Create docker-compose.override.yml
echo "Creating $COMPOSE_OVERRIDE..."
cat <<EOF > $COMPOSE_OVERRIDE
version: '3.8'

services:
  wireguard:
    image: $IMAGE_NAME
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    volumes:
      - /lib/modules:/lib/modules:ro
      - /usr/src:/usr/src:ro
EOF

# Step 4: Deploy the stack
echo "Deploying Docker Compose stack..."
docker-compose down
docker-compose up -d

# Final message
echo "Custom WireGuard container has been deployed with nftables support!"

## sudo ufw allow from <NPM_MACHINE_IP> to any port 8388

cd ..

