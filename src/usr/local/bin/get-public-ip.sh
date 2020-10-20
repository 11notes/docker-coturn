#!/bin/ash

if [ -z "$PUBLIC_IP" ]; then
  export $PUBLIC_IP="$(curl -4 https://ifconfig.me 2>/dev/null)"
fi

exec echo "$$PUBLIC_IP"