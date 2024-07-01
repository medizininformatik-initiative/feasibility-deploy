#!/usr/bin/env sh

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"


if ! [ -f "$BASE_DIR/auth/cert.pem" ]
then
  docker run --rm -v "$BASE_DIR/auth":/export --entrypoint openssl alpine/openssl \
    req -nodes -subj '/CN=localhost' \
    -addext "basicConstraints=CA:false" \
    -addext "subjectAltName = DNS:localhost, DNS:fhir.localhost, DNS:keycloak.localhost" \
    -x509 -newkey rsa:4096 -keyout /export/cert.key -out /export/cert.pem -days 99999
  docker run -v "$BASE_DIR/auth":/export alpine chmod +r "/export/cert.key"
fi

if ! [ -f "$BASE_DIR/auth/trust-store.p12" ]
then
  docker run --rm -v "$BASE_DIR/auth":/tls-cert \
    eclipse-temurin:17-jre-jammy@sha256:c1dd17f6b753f0af572069fb80dcacdc687f5d1ae3e05c98d5f699761b84a10a \
    keytool -importcert -storetype PKCS12 -keystore "/tls-cert/trust-store.p12" \
    -storepass "${TRUST_STORE_PASSWORD:-insecure}" -alias ca -file "/tls-cert/cert.pem" -noprompt
fi
