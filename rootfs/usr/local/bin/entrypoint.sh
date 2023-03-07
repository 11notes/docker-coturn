#!/bin/ash
  if [ -z "${1}" ]; then
    if [ -z "${IP}" ]; then IP=$(curl -4 https://ifconfig.me 2>/dev/null); fi
    set -- "turnserver" \
      -c /coturn/etc/turnserver.conf \
      --db=/coturn/var/sqlite.db \
      --pidfile=/coturn/run/turnserver.pid \
      --log-file=stdout \
      --external-ip=${IP}
  fi

  exec "$@"