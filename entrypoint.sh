#!/bin/bash
set -e

if [ -z "$MON_IP" ]; then
  hostname -i | tr " " "\n" > addresses.txt
  while read item; do
    if [[ "$item" =~ [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ ]];
    then
      echo "Choosing $item as IPv4 address"
      export MON_IP=$item
      exec /opt/ceph-container/bin/entrypoint.sh "$@"
    fi
  done < addresses.txt
  echo "Failed to discover an IPv4! Options were: " $(hostname -i)
  exit 1
else
  exec /opt/ceph-container/bin/entrypoint.sh "$@"
fi

