#!/bin/ash
  if [ -z "${IP}" ]; then IP=$(curl -4 https://ifconfig.me 2>/dev/null); fi

  if [ -z "${1}" ]; then
    cd /ics/bin
    set -- "turnserver" \
      -c /coturn/etc/turnserver.conf \
      --db=/coturn/var/sqlite.db \
      --pidfile=/coturn/run/turnserver.pid \
      --log-file=stdout \
      --external-ip=${IP}
  fi

  exec "$@"