#!/usr/bin/env sh

TORCH_BASE_URL=${TORCH_BASE_URL:-https://torch.localhost:444}
TORCH_USERNAME=${TORCH_USERNAME:-"test"}
TORCH_PASSWORD=${TORCH_PASSWORD:-"tast"}
CURL_INSECURE=${CURL_INSECURE:-false}

CURL_OPTIONS=""
if [ "$CURL_INSECURE" = "true" ]; then
    CURL_OPTIONS="-k"
fi

TORCH_AUTHORIZATION=$(printf "%s:%s" "$TORCH_USERNAME" "$TORCH_PASSWORD" | base64 -w0)

if [ "$#" -ne 1 ]; then
    printf "Usage: %s <path_to_json_file>\n" "$0"
    exit 1
fi

json_file="$1"
json_string=$(cat "$json_file")

base64_encoded=$(printf "%s" "$json_string" | base64 -w0)

response=$(curl --location -i $CURL_OPTIONS "${TORCH_BASE_URL}/fhir/\$extract-data" \
--header 'Content-Type: application/fhir+json' \
--header "Authorization: Basic ${TORCH_AUTHORIZATION}" \
--data '{
    "resourceType": "Parameters",
    "id": "example6",
    "parameter": [
        {
            "name": "crtdl",
            "valueBase64Binary": "'"$base64_encoded"'"
        }
    ]
}')

content_location=$(printf "%s" "$response" | grep -i 'Content-Location:' | awk '{print $2}' | tr -d '\r')

if [ -n "$content_location" ]; then
    printf "Extraction submitted, find your extraction under: %s$content_location\n" "$TORCH_BASE_URL"
else
    printf "Content-Location header not found in the response.\n"
fi
