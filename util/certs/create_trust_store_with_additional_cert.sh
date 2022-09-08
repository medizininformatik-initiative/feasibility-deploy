#!/usr/bin/env bash

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

docker build -t feasibility-deploy-create-trust-store "${BASE_DIR}"/
docker run  --name create-trust-store --rm \
    -v "${BASE_DIR}/your_certs":/opt/certs/your_certs \
    -v "${BASE_DIR}/trust_store_output":/opt/certs/output \
    feasibility-deploy-create-trust-store
