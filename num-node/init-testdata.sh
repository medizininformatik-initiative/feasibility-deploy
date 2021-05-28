#!/usr/bin/env sh

readlink "$0" >/dev/null
if [ $? -ne 0 ]; then
  BASE_DIR=$(dirname "$0")
else
  BASE_DIR=$(dirname "$(readlink "$0")")
fi

FILES=$BASE_DIR/testdata/*
for fhirBundle in $FILES; do
  echo "Sending Testdata bundle $fhirBundle ..."
  curl -X POST -H "Content-Type: application/json" -d @$fhirBundle http://localhost:8081/fhir
done
