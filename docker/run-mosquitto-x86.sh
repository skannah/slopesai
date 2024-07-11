#!/bin/bash

# Instructions: 

# Get the mosquitto server docker image
# docker pull eclipse-mosquitto

# Install the client tools 
# sudo apt-get install mosquitto-clients

# Create a directory on the host, just for testing
# /home/${USER}/PROJ3/mqtt

# Copy the mosquitto.conf to the directory path, just for testing 
# /home/${USER}/PROJ3/mqtt/config/mosquitto.conf

# Directories will be mounted in the container, like this. 
# /mosquitto/config/mosquitto.conf
# /mosquitto/data
# /mosquitto/log

# Set these values in the mosquitto.conf file, just for testing.  Note there is no security. 
# listener 1883
# persistence true
# persistence_location /mosquitto/data/
# log_dest stderr
# log_type error
# log_type warning
# log_type notice
# log_type information
# connection_messages true
# log_timestamp true
# allow_anonymous true

# Run the mosquitto server docker container like this.  The mosquitto directory is mounted from the host.
# Port 1883 is for TCP.  Port 9001 is for websocket. 
# docker run -it -p 1883:1883 -p 9001:9001 -v mosquitto.conf:/mosquitto/config/mosquitto.conf eclipse-mosquitto
# docker run -it -p 1883:1883 -v /home/${USER}/mqtt:/mosquitto eclipse-mosquitto

# Run each command in separate terminals, to test pub-sub client. 
# mosquitto_sub -h localhost -t "hello/test"
# mosquitto_pub -h localhost -t "hello/test" -m "hello world"
# mosquitto_sub -h localhost -t "hello/test" -u "username" -P "password"
# mosquitto_pub -h localhost -t "hello/test" -m "hello paul" -u "username" -P "password"

IMAGENAME="eclipse-mosquitto"
CONTAINERNAME="eclipse-mosquitto"

docker run \
  -d \
  --restart unless-stopped \
  -p 1883:1883 \
  -v "/home/${USER}/mqtt:/mosquitto" \
  --name "${CONTAINERNAME}" \
  "${IMAGENAME}"

