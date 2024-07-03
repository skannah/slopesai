#!/bin/bash
# PostgreSQL 
# https://hub.docker.com/_/postgres

# Instructions are here
# https://www.docker.com/blog/how-to-use-the-postgres-docker-official-image/

# docker pull postgres

IMAGENAME="postgres"
CONTAINERNAME="postgres"

mkdir -p "/home/${USER}/data"

docker run \
  -d \
  --restart unless-stopped \
  -p 5432:5432 \
  -e POSTGRES_DB=tinystore \
  -e POSTGRES_USER=tinystore \
  -e POSTGRES_PASSWORD=tinystore \
  -v "/home/${USER}/data:/var/lib/postgresql/data" \
  --name "${CONTAINERNAME}" \
  "${IMAGENAME}"

