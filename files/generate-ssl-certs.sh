#!/bin/bash

cd /opt/certbot

service nginx start -retry 30s -once

./certbot-auto certonly --webroot -w /app \
    -d $APP_HOSTNAME \
    --non-interactive --agree-tos --email $WEBMASTER

./certbot-auto certonly --webroot -w /api \
    -d $API_HOSTNAME \
    --non-interactive --agree-tos --email $WEBMASTER
