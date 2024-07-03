#!/bin/bash
# Use PGAdmin tool locally (x86) for Postgres which may be remote on RaspberryPi

# docker pull dpage/pgadmin4:latest

IMAGENAME="dpage/pgadmin4:latest"
CONTAINERNAME="pgadmin"

docker run \
  -d \
  --restart unless-stopped \
  -p 5051:80 \
  -e PGADMIN_DEFAULT_EMAIL=social.game.pro@gmail.com \
  -e PGADMIN_DEFAULT_PASSWORD=tinystore \
  -e PGADMIN_CONFIG_SERVER_MODE=False \
  --user root \
  --name "${CONTAINERNAME}" \
  "${IMAGENAME}"

