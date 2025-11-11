#!/bin/bash
set -e
ECR_URI="978439334699.dkr.ecr.ap-south-1.amazonaws.com/brain-tasks-app:latest"  # replace if needed
echo "Logging in and pulling from ECR..."
aws ecr get-login-password --region ap-south-1 | sudo docker login --username AWS --password-stdin 978439334699.dkr.ecr.ap-south-1.amazonaws.com
sudo docker pull "$ECR_URI"
echo "Stopping old and running new container..."
if sudo docker ps -a --format '{{.Names}}' | grep -q brain-app; then
  sudo docker stop brain-app || true
  sudo docker rm brain-app || true
fi
sudo docker run -d --name brain-app -p 3000:80 "$ECR_URI"
