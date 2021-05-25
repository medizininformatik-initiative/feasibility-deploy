#!/bin/sh

export COMPOSE_PROJECT=codex-deploy

if [ -z "$1" ] && [ -z "$2" ]; then
  echo "please provide a username and password"
  echo "setup-all-base-auth.sh <username> <password>"
  exit
fi

cd num-node
bash setup-base-auth.sh $1 $2

cd ../zars
bash setup-base-auth.sh
