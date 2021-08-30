#!/bin/ash
COTURN_EXTERNAL_IP=$(curl -4 https://ifconfig.me 2>/dev/null)
turnserver -c /coturn/etc/turnserver.conf --db=/coturn/var/sqlite.db --pidfile=/coturn/run/turnserver.pid --log-file=stdout --external-ip=${COTURN_EXTERNAL_IP} 