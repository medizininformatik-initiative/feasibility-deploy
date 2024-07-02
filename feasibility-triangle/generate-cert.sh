#!/usr/bin/env sh

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"

if [ ! -f "$BASE_DIR/auth/cert.pem"  ] || \
   { echo "Found existing certificate '$BASE_DIR/auth/cert.pem'." && \
     printf "Do you want to remove the existing certificate and create a new one? [y|n] " && \
     [ "$(read -r yn; echo "$yn")" = "y" ] ; }
then
  if [ -z "$CERT_DOMAINS" ]
  then
    if command -v nslookup
    then
      hostname="$(nslookup "$(hostname)" | grep '^Name:' | cut -f2 | tr '[:upper:]' '[:lower:]')"
    else
      hostname="$(hostname | tr '[:upper:]' '[:lower:]')"
    fi
    echo ""
    echo "Please provide the comma separated list of domain(s) the certificate will cover or leave empty to use defaults."
    echo "default domains: ${hostname:=localhost}"
    printf "domains: "
    read -r domains
  else
    hostname="$(echo "$CERT_DOMAINS" | sed -r 's/^([A-Za-z0-9_.-]+).*$/\1/')"
    domains="$CERT_DOMAINS"
  fi
  echo "Creating certificate for domains: ${domains:=$hostname}"
  hostname="$(echo "$domains" | sed -r 's/^([A-Za-z0-9_.-]+).*$/\1/')"
  docker run --rm -u "$(id -u):$(id -g)" -v "$BASE_DIR/auth":/export --entrypoint openssl alpine/openssl \
    req -nodes -subj "/CN=$hostname" \
    -addext "basicConstraints=CA:false" \
    -addext "subjectAltName = $(echo "$domains" | sed -r 's/([^, ]+)/DNS:\1/g')" \
    -x509 -newkey rsa:4096 -keyout /export/cert.key -out /export/cert.pem -days 99999
  chmod +r "$BASE_DIR/auth/cert.key"
fi

if [ ! -f "$BASE_DIR/auth/trust-store.p12" ] || \
   { echo "Trust store '$BASE_DIR/auth/trust-store.p12' found." && \
     printf "Recreate trust store? [y|n] " && \
     [ "$(read -r yn; echo "$yn")" = "y" ] ; }
then
  echo "Creating trust store $BASE_DIR/auth/trust-store.p12"
  rm -f "$BASE_DIR/auth/trust-store.p12"
  docker run --rm -u "$(id -u):$(id -g)" -v "$BASE_DIR/auth":/tls-cert \
    eclipse-temurin:17-jre-jammy@sha256:c1dd17f6b753f0af572069fb80dcacdc687f5d1ae3e05c98d5f699761b84a10a \
    keytool -importcert -storetype PKCS12 -keystore "/tls-cert/trust-store.p12" \
    -storepass "${TRUST_STORE_PASSWORD:-insecure}" -alias ca -file "/tls-cert/cert.pem" -noprompt
fi
