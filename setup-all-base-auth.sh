#!/usr/bin/env sh

readlink "$0" >/dev/null
if [ $? -ne 0 ]; then
  BASE_DIR=$(dirname "$0")
else
  BASE_DIR=$(dirname "$(readlink "$0")")
fi

if [ -z "$1" ] && [ -z "$2" ]; then
  echo "please provide a username and password"
  echo "setup-all-base-auth.sh <username> <password>"
  exit
fi

cd num-node
sh $BASE_DIR/num-node/setup-base-auth.sh $1 $2
sh $BASE_DIR/zars/setup-base-auth.sh
