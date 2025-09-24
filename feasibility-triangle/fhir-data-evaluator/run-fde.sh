#!/usr/bin/env bash

ONTOLOGY_VERSION="3.9.0"

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"

MEASURE_FILE="fdpg_availability_measure_v${ONTOLOGY_VERSION}.json"
DOWNLOAD_URL="https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/download/v${ONTOLOGY_VERSION}/availability.zip"
MEASURE_DIR="${BASE_DIR}/measure"
COMPOSE_PROJECT=${FEASIBILITY_COMPOSE_PROJECT:-feasibility-deploy}

# Create measure directory if it doesn't exist
mkdir -p "${BASE_DIR}/${MEASURE_DIR}"

# Check if measure file exists
if [ ! -f "${MEASURE_DIR}/${MEASURE_FILE}" ]; then
    echo -n "Downloading measure resource v${ONTOLOGY_VERSION} ... "
    # Download and extract measure resource
    curl -Ls -o "${BASE_DIR}/availability.zip" "$DOWNLOAD_URL"
    unzip -qj "${BASE_DIR}/availability.zip" "$MEASURE_FILE" -d "${MEASURE_DIR}"
    rm "${BASE_DIR}/availability.zip"
    echo "done."
fi

echo "Starting FHIR data evaluator ..."
COMPOSE_IGNORE_ORPHANS=True FDE_INPUT_MEASURE="${MEASURE_DIR}/${MEASURE_FILE}" docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR/docker-compose.yml" up -d
