# #!/bin/bash 
# cd server 

# # Variables
# DOCKERFILE="Dockerfile"
# CUSTOM_IMAGE="custom-wireguard"
# OVERRIDE_FILE="docker-compose.override.yml"

# # Step 1: Create the Dockerfile for the custom WireGuard image
# echo "Creating Dockerfile for custom WireGuard image..."
# cat <<EOF > $DOCKERFILE
# FROM linuxserver/wireguard

# # Install iptables for nftables compatibility
# RUN apk add --no-cache iptables
# EOF

# # Step 2: Build the custom Docker image
# echo "Building custom Docker image: $CUSTOM_IMAGE..."
# docker build -t $CUSTOM_IMAGE .

# # Step 3: Create a docker-compose.override.yml file to use the custom image
# echo "Creating $OVERRIDE_FILE to override WireGuard service..."
# cat <<EOF > $OVERRIDE_FILE
# version: '3.8'

# services:
#   wireguard:
#     image: $CUSTOM_IMAGE
#     cap_add:
#       - NET_ADMIN
#       - SYS_MODULE
#     volumes:
#       - /lib/modules:/lib/modules:ro
#       - /usr/src:/usr/src:ro
# EOF

# # Step 4: Deploy the Docker Compose stack
# echo "Deploying Docker Compose stack..."
# docker compose down
# docker compose up -d

# echo "Custom WireGuard container has been deployed with nftables support!"


# ## sudo ufw allow from <NPM_MACHINE_IP> to any port 8388

# cd ..

#!/bin/bash

cd server

echo "The script will now install the VPN"
echo "Updating ... "
dnf update -y


prompt() {
  local prompt_message=$1
  local default_value=$2
  read -p "$prompt_message [$default_value]: " input
  echo "${input:-$default_value}"
}

vpn_domain=$(prompt "Enter your domain for the wireguard" "vpn.example.com")
vpn_volume=$(prompt "Enter the volume for the wireguard" "/storage/wireguard")

sudo update-alternatives --set iptables /usr/sbin/iptables-nft
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-nft


cat <<EOF > docker-compose.yaml

services:
  wireguard:
    image: linuxserver/wireguard
    container_name: wireguard
    cap_add:
      - NET_ADMIN
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Brussels
      - SERVERURL=$vpn_domain
      - SERVERPORT=51820
      - PEERS=2
      - PEERDNS=auto
    volumes:
      - $vpn_volume/wireguard:/config
      - /lib/modules:/lib/modules:ro
    ports:
      - "51820:51820/udp"
    restart: unless-stopped

EOF

echo "The docker-compose.yaml has been created successfully."

docker compose up -d

docker ps

read -n 1 -s -r -p "Done. Press any key to continue..."

