#!/bin/bash

cd /opt/certbot

consul-template -consul=$CONSUL_URL -template="/templates/unsecured.ctmpl:/etc/nginx/nginx.conf:nginx -s reload" -retry 30s -once

./certbot-auto certonly --webroot -w /app \
    -d $APP_HOSTNAME \
    --non-interactive --agree-tos --email $WEBMASTER

./certbot-auto certonly --webroot -w /api \
    -d $API_HOSTNAME \
    --non-interactive --agree-tos --email $WEBMASTER

consul-template -consul=$CONSUL_URL -template="/templates/default.ctmpl:/etc/nginx/nginx.conf:nginx -s reload"
