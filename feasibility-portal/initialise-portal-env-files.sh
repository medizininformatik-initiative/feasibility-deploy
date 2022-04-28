#!/bin/sh

envfiles=( "gui/deploy-config.json" "backend/.env" "dsf-broker/.env" "keycloak/.env" "aktin-broker/.env")

for file in "${envfiles[@]}"
do
  if [[ -f "$file" ]]; then
    printf ".env file $file already exists - not copying default env \n"
    printf "Please check if your current env file $file is missing any params from the $file.default file and copy them as appropriate\n"
  else 
    cp "$file.default" $file
  fi   
done
