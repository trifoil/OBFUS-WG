#!/bin/bash 
sudo update-alternatives --set iptables /usr/sbin/iptables-nft
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-nft
cd server 
docker compose up -d

## sudo ufw allow from <NPM_MACHINE_IP> to any port 8388

cd ..

