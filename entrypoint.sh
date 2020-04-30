#!/bin/bash
set -e

if [ -z "$MON_IP" ]; then
  LINES=$(hostname -i | tr " " "\n")
  for item in "$LINES"
  do
    if [[ "$item" =~ [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ ]];
    then
      export MON_IP=$item
      exec /opt/ceph-container/bin/entrypoint.sh "$@"
    fi
  done
  echo "Failed to discover an IPv4! Options were: " $(hostname -i)
  exit 1
else
  exec /opt/ceph-container/bin/entrypoint.sh "$@"
fi

