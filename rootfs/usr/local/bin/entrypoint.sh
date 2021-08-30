#!/bin/ash
COTURN_EXTERNAL_IP=$(curl -4 https://ifconfig.me 2>/dev/null)
exec "$@ --external-ip=${COTURN_EXTERNAL_IP}" 