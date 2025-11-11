#!/bin/bash
set -e
# stop and remove existing container if present
if sudo docker ps -a --format '{{.Names}}' | grep -q brain-app; then
  echo "Stopping existing container..."
  sudo docker stop brain-app || true
  sudo docker rm brain-app || true
fi
