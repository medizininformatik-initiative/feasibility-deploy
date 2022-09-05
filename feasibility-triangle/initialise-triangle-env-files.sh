#!/bin/bash

envfiles=( "aktin-client/.env" "dsf-client/.env" "fhir-server/blaze-server/.env" "flare/.env" "rev-proxy/.env")

for file in "${envfiles[@]}"
do
  if [[ -f "$file" ]]; then
    printf ".env file %s already exists - not copying default env \n" "$file"
    printf "Please check if your current env file %s is missing any params from the %s file and copy them as appropriate\n" "$file" "$file.default"
  else
    cp "$file.default" "$file"
  fi
done
