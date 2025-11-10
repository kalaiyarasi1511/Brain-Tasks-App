#!/bin/bash
echo "Stopping old container if running..."
docker ps -q --filter "name=myapp" | grep -q . && docker stop myapp && docker rm myapp || echo "No container to stop"
