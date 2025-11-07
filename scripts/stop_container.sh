#!/bin/bash
echo "Stopping existing containers..."
container_id=$(sudo docker ps -q --filter "name=brain-app")

if [ -n "$container_id" ]; then
  sudo docker stop $container_id
  sudo docker rm $container_id
  echo "Stopped and removed container: $container_id"
else
  echo "No running container found."
fi

