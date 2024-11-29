#!/bin/bash 

cd server 
docker compose up -d

## sudo ufw allow from <NPM_MACHINE_IP> to any port 8388

cd ..

