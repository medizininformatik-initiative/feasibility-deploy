#!/bin/bash

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"
envfiles=( "$BASE_DIR/gui/deploy-config.json" "$BASE_DIR/backend/.env" "$BASE_DIR/keycloak/.env" "$BASE_DIR/proxy/.env")

for file in "${envfiles[@]}"
do
  if [[ -f "$file" ]]; then
    printf ".env file %s already exists - not copying default env \n" "$file"
    printf "Please check if your current env file %s is missing any params from the %s file and copy them as appropriate\n" "$file" "$file.default"
  else
    cp "$file.default" "$file"
  fi
done
