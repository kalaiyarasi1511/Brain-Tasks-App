set -euo pipefail
REGION=ap-south-1
DEPLOY_DIR="/home/ubuntu/brain-tasks-app"
IMAGEDEF="$DEPLOY_DIR/imagedefinitions.json"

if [ ! -f "$IMAGEDEF" ]; then
  echo "ERROR: imagedefinitions.json not found at $IMAGEDEF"
  exit 1
fi

IMAGE_URI=$(jq -r '.[0].imageUri' "$IMAGEDEF")
if [ -z "$IMAGE_URI" ] || [ "$IMAGE_URI" == "null" ]; then
  echo "ERROR: imageUri not found in $IMAGEDEF"
  exit 1
fi

echo "Logging into ECR and pulling $IMAGE_URI"
aws ecr get-login-password --region $REGION | sudo docker login --username AWS --password-stdin $(echo $IMAGE_URI | cut -d'/' -f1)

sudo docker pull "$IMAGE_URI"
sudo docker stop brain-tasks || true
sudo docker rm brain-tasks || true

sudo docker run -d --name brain-tasks -p 3000:80 --restart unless-stopped "$IMAGE_URI"
