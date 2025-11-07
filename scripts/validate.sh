set -e
echo "Validating app on localhost:3000..."
curl -fS --max-time 10 http://127.0.0.1:3000/ || { echo "Validation failed"; exit 1; }
echo "Validation OK"
