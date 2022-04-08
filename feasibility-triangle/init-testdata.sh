#!/usr/bin/env sh

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

FILES=$BASE_DIR/testdata/*
for fhirBundle in $FILES; do
  echo "Sending Testdata bundle $fhirBundle ..."
  curl -X POST -H "Content-Type: application/json" -d @$fhirBundle http://localhost:8081/fhir
done
