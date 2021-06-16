#!/usr/bin/env sh

# Arguments
#   1: docker-compose project token

readlink "$0" >/dev/null
if [ $? -ne 0 ]; then
  BASE_DIR=$(dirname "$0")
else
  BASE_DIR=$(dirname "$(readlink "$0")")
fi

# FHIR ------------------------------------------------------------------------

echo "Starting ZARS FHIR app..."
docker-compose -p $1 -f $BASE_DIR/docker-compose.yml up -d dsf-dic-fhir-proxy
echo -n "Waiting for full startup of the DSF DIC FHIR app..."
( docker-compose -p $1 -f $BASE_DIR/docker-compose.yml logs -f dsf-dic-fhir-app & ) | grep -E -q '^.* Server\.doStart.* \| Started.*'
echo "DONE"

# BPE -------------------------------------------------------------------------

echo -n "Setting permissions for ZARS BPE app..."
chmod a+w -R bpe/app/last_event
echo "DONE"

echo "Starting ZARS BPE app..."
docker-compose -p $1 -f $BASE_DIR/docker-compose.yml up -d dsf-dic-bpe-app
echo -n "Waiting for full startup of the DSF DIC BPE app..."
( docker-compose -p $1 -f $BASE_DIR/docker-compose.yml logs -f dsf-dic-bpe-app & ) | grep -E -q '^.* Server\.doStart.* \| Started.*'
echo "DONE"
