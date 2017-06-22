#!/bin/sh

: ${S3_BUCKET}
DC=$(curl -s http://localhost:8500/v1/catalog/datacenters | jq -r .[])
FILE="/tmp/$(hostname).snap"

if [ ${S3_BUCKET} ]; then
  consul snapshot save $FILE
  /usr/bin/aws s3 mv ${FILE} s3://${S3_BUCKET}/${DC}/consul/
else
  echo "S3_BUCKET is not set, consul-backup.sh is disabled."
  exit 0
fi
