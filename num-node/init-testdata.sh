#!/bin/bash


FILES=./testdata/*
for fhirBundle in $FILES
do
  echo "Sending Testdata bundle $fhirBundle ..."
  curl -X POST -H "Content-Type: application/json" -d @$fhirBundle http://localhost:8081/fhir
done
