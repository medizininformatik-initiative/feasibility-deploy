#!/usr/bin/env sh

if [ -z "$BASE_DIR" ]; then
  BASE_DIR=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )
fi

if [ -z "$1" ] && [ -z "$2" ]; then
  echo "please provide a username and password"
  echo "setup-all-base-auth.sh <username> <password>"
  exit
fi

echo "generating user '$1' with password '$2'"
docker run --rm -u "$(id -u):$(id -g)" --entrypoint htpasswd registry:2.7.0 -nb "$1" "$2" > "$BASE_DIR"/auth/.htpasswd
