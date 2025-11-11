#!/bin/bash
set -e
# simple health-check
if ! curl -sS http://127.0.0.1:3000/ >/dev/null; then
  echo "Application check failed"
  exit 1
fi
echo "Application is responding on local 3000"
