#!/bin/bash
nginx -g 'daemon off;' &
echo -n $LIVE > /var/live

/bin/generate-ssl-certs.sh
