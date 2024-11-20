#!/bin/bash

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"
envfiles=( "$BASE_DIR/fhir-server/.env" "$BASE_DIR/flare/.env" "$BASE_DIR/torch/.env" "$BASE_DIR/rev-proxy/.env" "$BASE_DIR/fhir-data-evaluator/.env")

for file in "${envfiles[@]}"
do
  if [[ -f "$file" ]]; then
    printf ".env file %s already exists - not copying default .env \n" "$file"
    printf "Please check if your current .env file %s is missing any params from the %s file and copy them as appropriate\n\n" "$file" "$file.default"
  else
    cp "$file.default" "$file"
    printf "Initialized .env file %s from template file %s\n\n" "$file" "$file.default"
  fi
done
