#!/bin/ash
  if [ -z "${WEBMGMT_PORT}" ]; then WEBMGMT_PORT=8080; fi
  curl --max-time 5 -kILs --fail https://localhost:${WEBMGMT_PORT}