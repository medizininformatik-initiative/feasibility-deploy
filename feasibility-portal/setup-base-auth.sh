#!/usr/bin/env sh

#FILE=$PWD/node-rev-proxy/dhparam.pem
#if [ ! -f "$FILE" ]; then
#    echo "Creating longer Diffie-Hellman Prime for extra security... this may take a while \n\n"
#    docker run --rm -v $PWD/node-rev-proxy:/export --entrypoint openssl alpine/openssl dhparam -out /export/dhparam.pem 4096
#    echo $FILE
#
#fi

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"

echo "Generating default certificate..."
docker run --rm -v "$BASE_DIR"/auth:/export --entrypoint openssl alpine/openssl req -nodes -subj '/CN=localhost' -addext "subjectAltName = DNS:datenportal.localhost, DNS:auth.datenportal.localhost, DNS:api.datenportal.localhost" -x509 -newkey rsa:4096 -keyout /export/key.pem -out /export/cert.pem -days 99999
docker run --rm -v "$BASE_DIR"/auth:/export alpine chmod -R 655 /export

#echo "generating user: $1 , with password: $2"
#docker run --rm --entrypoint htpasswd registry:2.7.0 -nb $1 $2 > .htpasswd
