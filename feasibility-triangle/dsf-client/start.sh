#!/usr/bin/env bash

# Arguments
#   1: docker-compose project

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"

# FHIR ------------------------------------------------------------------------

echo -n "Setting up folders and permissions for ZARS FHIR app..."
mkdir -p "$BASE_DIR/fhir/log"
chmod a+w -R "$BASE_DIR/fhir"
echo "DONE"

echo "Starting ZARS FHIR app..."
docker-compose -p "$1" -f "$BASE_DIR/docker-compose.yml" up -d dsf-dic-fhir-proxy
echo -n "Waiting for full startup of the DSF DIC FHIR app..."
( docker-compose -p "$1" -f "$BASE_DIR/docker-compose.yml" logs -f dsf-dic-fhir-app & ) | grep -E -q '^.* Server\.doStart.* \| Started.*'
echo "DONE"

# BPE -------------------------------------------------------------------------

echo -n "Setting up folders and permissions for ZARS BPE app..."
mkdir -p "$BASE_DIR/bpe/log"
mkdir -p "$BASE_DIR/bpe/cache"
mkdir -p "$BASE_DIR/bpe/last_event"
mkdir -p "$BASE_DIR/process"
chmod a+w -R "$BASE_DIR/bpe"
chmod a+r -R "$BASE_DIR/process"
echo "DONE"

echo "Starting ZARS BPE app..."
docker-compose -p "$1" -f "$BASE_DIR/docker-compose.yml" up -d dsf-dic-bpe-app
echo -n "Waiting for full startup of the DSF DIC BPE app..."
( docker-compose -p "$1" -f "$BASE_DIR/docker-compose.yml" logs -f dsf-dic-bpe-app & ) | grep -E -q '^.* Server\.doStart.* \| Started.*'
echo "DONE"
