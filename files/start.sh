#!/bin/bash
nginx -g 'daemon off;' &
echo -n $LIVE > /var/live
consul-template -consul=$CONSUL_URL -template="/templates/default.ctmpl:/etc/nginx/nginx.conf:service nginx reload"
