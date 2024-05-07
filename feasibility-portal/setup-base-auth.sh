#!/usr/bin/env bash

#FILE=$PWD/node-rev-proxy/dhparam.pem
#if [ ! -f "$FILE" ]; then
#    echo "Creating longer Diffie-Hellman Prime for extra security... this may take a while \n\n"
#    docker run --rm -v $PWD/node-rev-proxy:/export --entrypoint openssl alpine/openssl dhparam -out /export/dhparam.pem 4096
#    echo $FILE
#
#fi

RED='\033[0;31m'
NC='\033[0m' # No Color

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"

echo "Generating default certificate..."
docker run --rm -u "$(id -u):$(id -g)" -v "$BASE_DIR"/auth:/export alpine/openssl req -nodes -subj '/CN=local-ca' -x509 -newkey rsa:4096 -keyout /export/ca-key.pem -out /export/ca-cert.pem -days 99999
docker run --rm -u "$(id -u):$(id -g)" -v "$BASE_DIR"/auth:/export alpine/openssl req -nodes -subj '/CN=localhost' -x509 -CA /export/ca-cert.pem -CAkey /export/ca-key.pem -addext "basicConstraints=CA:false" -addext "subjectAltName = DNS:datenportal.localhost, DNS:auth.datenportal.localhost, DNS:api.datenportal.localhost" -newkey rsa:4096 -keyout /export/key.pem -out /export/cert.pem -days 99998
docker run --rm -u "$(id -u):$(id -g)" -v "$BASE_DIR"/auth:/export alpine chmod -R 655 /export/cert.pem /export/key.pem
if [ -f "$BASE_DIR"/auth/ca-cert.pem ] && [ -f "$BASE_DIR"/auth/cert.pem ]
then
  echo "Certificate has been generated."
  echo
  echo -e "${RED}## IMPORTANT ##${NC}"
  echo "1. Import the ca certificate '$BASE_DIR/auth/ca-cert.pem' in your browser's certificate store and trust it with"
  echo "   identifying websites."
  echo
  echo "2. Add the following line to your hosts file (e.g. '/etc/hosts'):"
  echo
  echo "    127.0.0.1  datenport.localhost auth.datenportal.localhost api.datenportal.localhost"
  echo
  echo "  If the portal will not be running on your local computer replace '127.0.0.1' with the actual ip address where"
  echo "  the portal will be running."
  echo
fi


#echo "generating user: $1 , with password: $2"
#docker run --rm --entrypoint htpasswd registry:2.7.0 -nb $1 $2 > .htpasswd
