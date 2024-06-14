#!/bin/bash
set -e

COMPOSE_PROJECT=${FEASIBILITY_COMPOSE_PROJECT:-feasibility-deploy}
BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"
CLIENT_ID="$(docker inspect --format '{{range .Config.Env}}{{ if eq (index (split . "=") 0) "AUTH_CLIENT_ID" }}{{ println (index (split . "=") 1)}}{{end}}{{end}}' "$COMPOSE_PROJECT-fhir-server-frontend-1")"
CLIENT_SECRET="$(docker inspect --format '{{range .Config.Env}}{{ if eq (index (split . "=") 0) "AUTH_CLIENT_SECRET" }}{{ println (index (split . "=") 1)}}{{end}}{{end}}' "$COMPOSE_PROJECT-fhir-server-frontend-1")"
ISSUER_URL="$(docker inspect --format '{{range .Config.Env}}{{ if eq (index (split . "=") 0) "AUTH_ISSUER" }}{{ println (index (split . "=") 1)}}{{end}}{{end}}' "$COMPOSE_PROJECT-fhir-server-frontend-1")"
docker run --rm --network host -v "$BASE_DIR/auth/:/auth" alpine sh -c \
  "apk --quiet --no-progress add jq curl; \
   curl -s -d 'client_id=$CLIENT_ID' -d 'client_secret=$CLIENT_SECRET' -d 'grant_type=client_credentials' --cacert /auth/cert.pem '$ISSUER_URL/protocol/openid-connect/token' \
   | jq -r '.access_token'"
