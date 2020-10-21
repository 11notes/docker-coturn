#!/bin/ash

echo "DOCKER :: ENTRYPOINT"
echo "$@"

if [ "${1:0:1}" == '-' ]; then
  set -- turnserver "$@"
fi

exec $(eval "echo $@")