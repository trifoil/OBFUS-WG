#!/bin/bash

cd wg-server/
docker compose up -d
read -n 1 -s -r -p "Done. Press any key to continue..."
cd ..

cd ss-server/
docker compose up -d
read -n 1 -s -r -p "Done. Press any key to continue..."
cd ..