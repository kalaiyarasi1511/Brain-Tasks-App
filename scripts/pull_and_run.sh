#!/bin/bash
echo "Pulling latest image from ECR..."

# Login to Amazon ECR
aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 978439334699.dkr.ecr.us-east-1.amazonaws.com

# Pull latest image
sudo docker pull 978439334699.dkr.ecr.us-east-1.amazonaws.com/brain-tasks-app:latest

# Stop and remove old container if running
old_container=$(sudo docker ps -q --filter "name=brain-app")
if [ -n "$old_container" ]; then
  echo "Stopping old container..."
  sudo docker stop $old_container
  sudo docker rm $old_container
fi

# Run new container
echo "Running new container..."
sudo docker run -d --name brain-app -p 80:80 978439334699.dkr.ecr.us-east-1.amazonaws.com/brain-tasks-app:latest

echo "✅ Deployment completed successfully."
