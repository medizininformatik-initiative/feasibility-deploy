#!/bin/sh

cp feasibility-portal/gui/deploy-config.default.json feasibility-portal/gui/deploy-config.json
cp feasibility-portal/backend/.env.default feasibility-portal/backend/.env
cp feasibility-portal/dsf-broker/.env.default feasibility-portal/dsf-broker/.env
cp feasibility-portal/keycloak/.env.default feasibility-portal/keycloak/.env
cp feasibility-portal/aktin-broker/.env.default feasibility-portal/aktin-broker/.env

cp feasibility-triangle/aktin-client/.env.default feasibility-triangle/aktin-client/.env
cp feasibility-triangle/dsf-client/.env.default feasibility-triangle/dsf-client/.env
cp feasibility-triangle/fhir-server/blaze-server/.env.default feasibility-triangle/fhir-server/blaze-server/.env
cp feasibility-triangle/flare/.env.default feasibility-triangle/flare/.env
cp feasibility-triangle/rev-proxy/.env.default feasibility-triangle/rev-proxy/.env


