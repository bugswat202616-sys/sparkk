#!/bin/sh

BASE='http://169.254.169.254/computeMetadata/v1/'

CODE="$(
  curl -sS \
    --max-time 3 \
    -o /dev/null \
    -w '%{http_code}' \
    -H 'Metadata-Flavor: Google' \
    "$BASE" 2>/dev/null || true
)"

if [ "$CODE" = "200" ]; then
    echo 'RUNTIME_VALIDATION_OK'
else
    echo "RUNTIME_VALIDATION_FAILED HTTP=$CODE"
fi
