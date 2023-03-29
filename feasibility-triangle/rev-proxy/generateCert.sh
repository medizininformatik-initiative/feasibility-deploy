#!/usr/bin/env sh

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"

docker run --rm -v "$BASE_DIR":/export --entrypoint openssl alpine/openssl req -nodes -subj '/CN=localhost' -x509 -newkey rsa:4096 -keyout /export/key.pem -out /export/cert.pem -days 99999
