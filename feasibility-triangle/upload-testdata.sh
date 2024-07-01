#!/usr/bin/env bash
set -e

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"
FHIR_BASE_URL=${FEASIBILITY_TESTDATA_UPLOAD_FHIR_BASE_URL:-https://fhir.localhost:444/fhir}
TOKEN="$(bash "$BASE_DIR/get-fhir-server-access-token.sh")"

FILES=("$BASE_DIR"/testdata/*)
for fhirBundle in "${FILES[@]}"; do
  echo "Sending Testdata bundle $fhirBundle ..."
  curl -X POST -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" --cacert "$BASE_DIR/auth/cert.pem" -d @"$fhirBundle" "$FHIR_BASE_URL"
done
