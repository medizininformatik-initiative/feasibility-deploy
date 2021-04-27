#!/bin/bash
ALLOWED_IPS=${ALLOWED_IPS:-""}

echo $ALLOWED_IPS

ips=$(echo $ALLOWED_IPS | tr ",'" "\n")

printf "" > /etc/nginx/conf.d/queue_allow_ips.conf

for ip in $ips
do
    echo "allow $ip;"  >> /etc/nginx/conf.d/queue_allow_ips.conf
done

if [[ -n $ALLOWED_IPS ]];then
    echo "deny all;"  >> /etc/nginx/conf.d/queue_allow_ips.conf
fi

#starting nginx
nginx -g 'daemon off;'
