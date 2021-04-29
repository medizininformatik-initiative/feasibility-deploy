#!/usr/bin/env bash

# Arguments
#   1: docker-compose project token

# FHIR ------------------------------------------------------------------------

echo "Starting ZARS FHIR app..."
docker-compose -p $1 up -d dsf-dic-fhir-proxy
echo -n "Waiting for full startup of the DSF DIC FHIR app..."
( docker-compose -p $1 logs -f dsf-dic-fhir-app & ) | grep -E -q '^.* Server\.doStart.* \| Started.*'
echo "DONE"

# BPE -------------------------------------------------------------------------

echo -n "Setting permissions for ZARS BPE app..."
chmod a+w -R bpe/app/last_event
echo "DONE"

echo "Starting ZARS BPE app..."
docker-compose -p $1 up -d dsf-dic-bpe-app
echo -n "Waiting for full startup of the DSF DIC BPE app..."
( docker-compose -p $1 logs -f dsf-dic-bpe-app & ) | grep -E -q '^.* Server\.doStart.* \| Started.*'
echo "DONE"
