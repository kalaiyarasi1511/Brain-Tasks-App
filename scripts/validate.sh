#!/bin/bash
if curl -sSf http://127.0.0.1:80 >/dev/null; then
  echo "OK"
  exit 0
else
  echo "BAD"
  exit 1
fi
