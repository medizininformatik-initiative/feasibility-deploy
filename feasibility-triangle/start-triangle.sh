#!/usr/bin/env sh

COMPOSE_PROJECT=${FEASIBILITY_COMPOSE_PROJECT:-feasibility-deploy}
BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"
CERT_FILE=${CERT_FILE:-$BASE_DIR/auth/cert.pem}
KEY_FILE=${KEY_FILE:-$BASE_DIR/auth/cert.key}
TRUST_STORE_FILE=${KEY_FILE:-$BASE_DIR/auth/trust-store.p12}


if [ -f "$BASE_DIR/fhir-server/.env" ] && grep -qE '^FHIR_SERVER_FRONTEND_KEYCLOAK_ENABLED=true\s*$' "$BASE_DIR/fhir-server/.env"; then
    if [ ! -f "$BASE_DIR/rev-proxy/conf.d/keycloak.conf" ]; then
        cp "$BASE_DIR/rev-proxy/conf.d/keycloak.conf.template" "$BASE_DIR/rev-proxy/conf.d/keycloak.conf"
    fi
    COMPOSE_IGNORE_ORPHANS=True docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/fhir-server/keycloak.docker-compose.yml up -d --wait
else
    if [ -f "$BASE_DIR/rev-proxy/conf.d/keycloak.conf" ]; then
        rm "$BASE_DIR/rev-proxy/conf.d/keycloak.conf"
    fi
fi
if [ -f "$CERT_FILE" ] && [ -f "$KEY_FILE" ]; then
    if [ -f "$TRUST_STORE_FILE" ]; then
        COMPOSE_IGNORE_ORPHANS=True docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/rev-proxy/docker-compose.yml up -d
        COMPOSE_IGNORE_ORPHANS=True docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/fhir-server/docker-compose.yml up -d --wait
    else
        echo "Trust store ($TRUST_STORE_FILE) file is missing. Please run '$BASE_DIR/generate-cert.sh' and then retry."
        exit 1
    fi
else
    echo "One of or both cert ($CERT_FILE) and key ($KEY_FILE) files are missing => NOT starting NGINX reverse proxy on port $PORT_NUM_NODE_REV_PROXY"
    exit 1
fi

if [ -f "$BASE_DIR/flare/.env" ] && grep -qE '^FLARE_ENABLED=true\s*$' "$BASE_DIR/flare/.env"; then
    if [ ! -f "$BASE_DIR/rev-proxy/conf.d/flare.conf" ]; then
        cp "$BASE_DIR/rev-proxy/conf.d/flare.conf.template" "$BASE_DIR/rev-proxy/conf.d/flare.conf"
    fi
    COMPOSE_IGNORE_ORPHANS=True docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/flare/docker-compose.yml up -d
else
    if [ -f "$BASE_DIR/rev-proxy/conf.d/flare.conf" ]; then
        rm "$BASE_DIR/rev-proxy/conf.d/flare.conf"
    fi
fi

if [ -f "$BASE_DIR/torch/.env" ] && grep -qE '^TORCH_ENABLED=true\s*$' "$BASE_DIR/torch/.env"; then
    if [ ! -f "$BASE_DIR/rev-proxy/conf.d/torch.conf" ]; then
        cp "$BASE_DIR/rev-proxy/conf.d/torch.conf.template" "$BASE_DIR/rev-proxy/conf.d/torch.conf"
    fi
    COMPOSE_IGNORE_ORPHANS=True docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/torch/docker-compose.yml up -d
else
    if [ -f "$BASE_DIR/rev-proxy/conf.d/torch.conf" ]; then
        rm "$BASE_DIR/rev-proxy/conf.d/torch.conf"
    fi
fi