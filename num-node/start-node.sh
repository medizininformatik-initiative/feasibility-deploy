#!/usr/bin/env sh

COMPOSE_PROJECT=codex-deploy
export PORT_NUM_NODE_REV_PROXY=444

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
FHIR_SERVER=${FHIR_SERVER:-blaze}
CERT_FILE=${CERT_FILE:-$BASE_DIR/auth/cert.pem}
KEY_FILE=${KEY_FILE:-$BASE_DIR/auth/key.pem}

docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/aktin-client/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/flare/docker-compose.yml up -d

if [ "$FHIR_SERVER" = "blaze" ]; then
    echo "Starting up FHIR-Server: Blaze"
    docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/fhir-server/blaze-server/docker-compose.yml up -d
elif [ "$FHIR_SERVER" = "hapi" ]; then
    echo "Starting up FHIR-Server: HAPI"
    docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/fhir-server/hapi-fhir-server/docker-compose.yml up -d
fi

if [ "$FHIR_SERVER" = "blaze" ]; then
    echo "Starting up FHIR-Server: Blaze"
    docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/fhir-server/blaze-server/docker-compose.yml up -d
elif [ "$FHIR_SERVER" = "hapi" ]; then
    echo "Starting up FHIR-Server: HAPI"
    docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/fhir-server/hapi-fhir-server/docker-compose.yml up -d
fi



if [ -f "$CERT_FILE" ] && [ -f "$KEY_FILE" ]; then
    echo "Auth files cert: $CERT_FILE and key: $KEY_FILE exist => starting NGINX reverse proxy on port $PORT_NUM_NODE_REV_PROXY"
    docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/rev-proxy/docker-compose.yml up -d
else
    echo "One of or both cert ($CERT_FILE) and key ($KEY_FILE) files missing => NOT starting NGINX reverse proxy on port $PORT_NUM_NODE_REV_PROXY"
    echo "Note that your feasibility triangle will still work, but will only be accessible from localhost"
fi
