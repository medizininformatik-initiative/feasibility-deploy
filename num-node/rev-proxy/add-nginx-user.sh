#!/bin/sh
echo "generating user and pw: $1 , $2"
docker run --rm --entrypoint htpasswd registry:2.7.0 -nb $1 $2 >> .htpasswd
