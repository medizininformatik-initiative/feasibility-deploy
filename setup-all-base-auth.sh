#!/usr/bin/env sh

BASE_DIR=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )

if [ -z "$1" ] && [ -z "$2" ]; then
  echo "please provide a username and password"
  echo "setup-all-base-auth.sh <username> <password>"
  exit
fi

cd num-node
sh $BASE_DIR/num-node/setup-base-auth.sh $1 $2
sh $BASE_DIR/zars/setup-base-auth.sh
