#!/usr/bin/env sh

TORCH_BASE_URL=${TORCH_BASE_URL:-https://torch.localhost:444}
TORCH_USERNAME=${TORCH_USERNAME:-"test"}
TORCH_PASSWORD=${TORCH_PASSWORD:-"tast"}
CURL_INSECURE=${CURL_INSECURE:-false}

CURL_OPTIONS=""
if [ "$CURL_INSECURE" == "true" ]; then
    CURL_OPTIONS="-k"
fi

TORCH_AUTHORIZATION=$(echo -n "${TORCH_USERNAME}:${TORCH_PASSWORD}" | base64)

if [ $# -ne 1 ]; then
    echo "Usage: $0 <path_to_json_file>"
    exit 1
fi

json_file="$1"
json_string=$(<"$json_file")

base64_encoded=$(echo -n "$json_string" | base64)

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

content_location=$(echo "$response" | grep -i 'Content-Location:' | awk '{print $2}' | tr -d '\r')

if [ -n "$content_location" ]; then
    echo "Extraction submitted, find your extraction under: $TORCH_BASE_URL$content_location"
else
    echo "Content-Location header not found in the response."
fi