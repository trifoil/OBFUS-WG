#!/bin/bash 
cd server 

# Variables
DOCKERFILE="Dockerfile"
CUSTOM_IMAGE="custom-wireguard"
OVERRIDE_FILE="docker-compose.override.yml"

# Step 1: Create the Dockerfile for the custom WireGuard image
echo "Creating Dockerfile for custom WireGuard image..."
cat <<EOF > $DOCKERFILE
FROM linuxserver/wireguard

# Install iptables for nftables compatibility
RUN apk add --no-cache iptables
EOF

# Step 2: Build the custom Docker image
echo "Building custom Docker image: $CUSTOM_IMAGE..."
docker build -t $CUSTOM_IMAGE .

# Step 3: Create a docker-compose.override.yml file to use the custom image
echo "Creating $OVERRIDE_FILE to override WireGuard service..."
cat <<EOF > $OVERRIDE_FILE
version: '3.8'

services:
  wireguard:
    image: $CUSTOM_IMAGE
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    volumes:
      - /lib/modules:/lib/modules:ro
      - /usr/src:/usr/src:ro
EOF

# Step 4: Deploy the Docker Compose stack
echo "Deploying Docker Compose stack..."
docker compose down
docker compose up -d

echo "Custom WireGuard container has been deployed with nftables support!"


## sudo ufw allow from <NPM_MACHINE_IP> to any port 8388

cd ..

