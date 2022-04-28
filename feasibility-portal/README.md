# Feasibility Portal

The feasibility portal provides a feasibility query user interface with an appropriate backend, query translation to CQL and FHIR Search as well as 
the central part of two Middleware for the transfer of the queries from the feasibility portal to the feasibility triangles located at participating sites (hospitals).


## Setting up the Feasibility Portal - Local Installation

### Step 1 - Installation Docker

The installation of the Feasibility Triangle requires Docker (https://docs.docker.com/engine/install/ubuntu/) and docker-compose (https://docs.docker.com/compose/install/).
If not already installed on your VM, install using the links provided above.

### Step 2 - clone this Repository to your virtual machine

ssh to your virtual machine and switch to sudo `sudo -s`.
Designate a folder for your setup in which to clone the deploy repository, we suggest /opt (`cd /opt`)
Navigate to the directory and clone this repository: `git clone https://github.com/medizininformatik-initiative/feasibility-deploy.git`
Navigate to the feasibility-triangle folder of the repository: `cd /opt/feasibility-deploy/feasibility-portal`
Checkout the version (git tag) of the feasibility triangle you would like to install: `git checkout tags/<your-tag-name-here>`

### Step 3 - Initialise .env files

The feasibility portal requires .env files for the docker-compose setup. If you are setting up the project new and have not done so yet execute the `initialise-portal-env-files.sh`.

If you have set up the portal before compare the .env to the .env.default env files of each component and copy the additional params as appropriate

### Step 4 - Set Up ssl certificates

Running this setup safely at your site, requires a valid certificate and domain. Please contact the responsible body of your institution to recieve both a domain and certificate.
You will require two .pem files: a cert.pem (certificate) and key.pem (private key).

Once you have the appropriate certificates you should save them under `/opt/feasibility-deploy/feasibility-portal/auth`.
Set the rights for all files of the auth folder to 655 `chmod 655 /opt/feasibility-deploy/feasibility-portal/auth/*`.  

- Not providing the certificate files is not an option.

### Step 5 - Load the ontology mapping files

If used, (see "Overview") The FLARE component requires a mapping file and ontology tree file to translate an incoming feasibility query into FHIR Search queries.
Both can be downloaded here: https://confluence.imi.med.fau.de/display/ABIDEMI/Ontologie

Upload the ontology .zip files to your server, unpack them and copy the ontology files to your feasibility portal ontology folder

```bash
sudo -s
mkdir /<path>/<to>/<folder>/<of>/<choice>
cd /<path>/<to>/<folder>/<of>/<choice>
unzip mapping_*.zip
unzip ui_profiles_*.zip
cd mapping
cp * /opt/feasibility-deploy/feasibility-portal/ontology
cd ../ui_profiles
cp * /opt/feasibility-deploy/feasibility-portal/ontology/ui_profiles
```

### Step 6 - Configure your feasibility portal

If you use the default local feasibility portal setup you will only have to change the following environment variables:

| file | environment variable | value for local setup |
|--|--|--|
|keycloak/.env|FEASIBILITY_KEYCLOAK_BASE_URL| base-url-of-your-local-feasibility-portal/auth |
|keycloak/.env|FEASIBILITY_KEYCLOAK_ADMIN_PW| choose a secure password here e.g. Ykc2PINWatNqL5Wq,OIxFz1Sv3dzmQ2|
|backend/.env|FEASIBILITY_BACKEND_AKTIN_ENABLED|false|
|backend/.env|FEASIBILITY_BACKEND_DIRECT_ENABLED|true|
|backend/.env|FEASIBILITY_BACKEND_API_BASE_URL|base-url-of-your-local-feasibility-portal/api|
|backend/.env|FLARE_WEBSERVICE_BASE_URL|http://flare:8080|
|backend/.env|FEASIBILITY_BACKEND_ALLOWED_ORIGINS|base-url-of-your-local-feasibility-portal|

For more details on the environment variables see the paragraph **Configurable environment variables** of this README.

### Step 7 - Start the feasibility portal

To start the portal navigate to `/opt/feasibility-deploy/feasibility-portal/start-feasibility-portal-local.sh` and
execute `bash start-feasibility-portal-local.sh`.

This starts the following default local feasibility portal, with the following components:

|Component|url|description|
|--|--|--|
|GUI|https://my-fesibility-domain||
|Keycloak|https://my-feasibility-domain/auth||


### Step 8 - Configure keycloak and add a user for the user interface

Navigate with your browser to https://my-fesibility-domain/auth
and log in to keyloak using the admin password set in step 6 (FEASIBILITY_KEYCLOAK_ADMIN_PW).
User: admin
Pw: my password set in step 6

1. Set the your domain for your client:
Click on `Clients > feasibility-gui` and change the fields: Root URL, Base URL and Web Origins
from: https://feasibility.forschen-fuer-gesundheit.de
to: https://your-feasibility-domain

and **Valid Redirect URIs**
from 
from: https://feasibility.forschen-fuer-gesundheit.de
to: https://your-feasibility-domain/*

2. Add a user for to your feasibility user interface:
Click on `Users > Add User` and fill in the field **Username** with a username of your choice and add the user under **Groups** to the group **/codex-develop**. 
Click on **Credentials** and type a password of your choice and confirm it.

### Step 9 - Access the user interface and send first query

Access your user interface under <https://your-feasibility-domain> and log in with the user set in step 8.

Click on **New query**, create a query and send it using the **send** button.
After a few moments you should see the results to your query in the **Number of patients** window.


## Configurable environment variables


|Env Var|Description|Default|Possible values|Component|
|--|--|--|--|--|
|AKTIN_BROKER_LOG_LEVEL|Log level of the Aktin broker|INFO||AKTIN|
|AKTIN_ADMIN_PW|password for the web admin of the AKTIN broker Admin is accessible via: http://localhost:AKTIN_BROKER_HOST_AND_PORT/admin/html/index.html|changeme||AKTIN|
|AKTIN_BROKER_HOST_AND_PORT|Aktin broker Docker port |127.0.0.1:8080||AKTIN|
|FEASIBILITY_BACKEND_DATASOURCE_HOST|backend database host|feasibility-gui-backend-db||BACKEND|
|FEASIBILITY_BACKEND_DATASOURCE_PORT|backend database port|5432||BACKEND|
|FEASIBILITY_BACKEND_DATASOURCE_USERNAME|backend database username|guidbuser||BACKEND|
|FEASIBILITY_BACKEND_DATASOURCE_PASSWORD|backend database password|guidbpw||BACKEND|
|FEASIBILITY_BACKEND_KEYCLOAK_ENABLED|whether or not keycloak is enabled for the backend|true||BACKEND|
|KEYCLOAK_ALLOWED_ROLE|The keycloak role required to access the backend|FEASIBILITY_USER||BACKEND|
|FEASIBILITY_BACKEND_KEYCLOAK_BASE_URL|the url the backend uses to access keycloak|http://keycloak:8080||BACKEND|
|FEASIBILITY_BACKEND_KEYCLOAK_REALM|the realm the backend uses within keyloak|codex-develop||BACKEND|
|FEASIBILITY_BACKEND_KEYCLOAK_CLIENT_ID|the id of the keyloak client for the backend|feasibility-gui||BACKEND|
|FEASIBILITY_BACKEND_CQL_TRANSLATE_ENABLED|enables CQL translation|true||BACKEND|
|FEASIBILITY_BACKEND_FHIR_TRANSLATE_ENABLED|enables FHIR Search translation. This is only required if a site has their own FLARE component it wishes to use|false||BACKEND|
|FEASIBILITY_BACKEND_API_BASE_URL|the api url of the backend. If using an nginx this url should be the url of the nginx, which forwards to the backend|https://localhost/api/||BACKEND|
|FEASIBILITY_BACKEND_DIRECT_ENABLED|enables the direct broker. This connects the backend directly to flare and is only meant to be used for a local installation|false||BACKEND|
|FEASIBILITY_BACKEND_FLARE_WEBSERVICE_BASE_URL|the url of the flare component the backend should connect to when using the direct broker|http://flare:8080||BACKEND|
|FEASIBILITY_BACKEND_ALLOWED_ORIGINS|base-url-of-your-local-feasibility-portal |https://localhost||BACKEND|
|FEASIBILITY_BACKEND_AKTIN_ENABLED|enables the aktin broker|false||BACKEND|
|FEASIBILITY_BACKEND_AKTIN_BROKER_BASE_URL|aktin broker base url|http://aktin-broker:8080/broker/||BACKEND|
|FEASIBILITY_BACKEND_AKTIN_BROKER_API_KEY|aktin broker admin api key. The backend needs admin access as it requires permission to post new queries to the broker|xxxApiKeyAdmin123||BACKEND|
|FEASIBILITY_BACKEND_DSF_ENABLED|enables the dsf|false||BACKEND|
|FEASIBILITY_BACKEND_DSF_CACERT||/opt/codex-feasibility-security/ca.pem||BACKEND|
|FEASIBILITY_BACKEND_DSF_DSF_SECURITY_KEYSTORE_P12FILE||/opt/codex-feasibility-security/test-user.p12||BACKEND|
|FEASIBILITY_BACKEND_DSF_SECURITY_KEYSTORE_PASSWORD||password||BACKEND|
|FEASIBILITY_BACKEND_DSF_WEBSERVICE_BASE_URL||https://dsf-zars-fhir-proxy/fhir||BACKEND|
|FEASIBILITY_BACKEND_DSF_WEBSOCKET_URL||wss://dsf-zars-fhir-proxy:443/fhir/ws||BACKEND|
|FEASIBILITY_BACKEND_DSF_ORGANIZATION_ID||Test_ZARS||BACKEND|
|FEASIBILITY_BACKEND_UI_PROFILES_PATH|path on host where the backend searches for the ui profiles|../ontology/ui_profiles||BACKEND|
|FEASIBILITY_BACKEND_CONCEPT_TREE_PATH|path on host where the backend looks for the code tree file|../ontology/codex-code-tree.json||BACKEND|
|FEASIBILITY_BACKEND_TERM_CODE_MAPPING_PATH|path on host where the backend looks for the mapping file|../ontology/codex-term-code-mapping.json||BACKEND|
|FEASIBILITY_BACKEND_CERTS_PATH||../dsf-broker/certs||BACKEND|
|FEASIBILITY_KEYCLOAK_DB|keycloak database host|keycloakdb||KEYCLOAK|
|FEASIBILITY_KEYCLOAK_DB_USER|keycloak database username|keycloakdbuser||KEYCLOAK|
|FEASIBILITY_KEYCLOAK_DB_PW|keycloak database password|keycloakdbpw||KEYCLOAK|
|FEASIBILITY_KEYCLOAK_ADMIN_USER|keycloak admin username|admin||KEYCLOAK|
|FEASIBILITY_KEYCLOAK_ADMIN_PW|keycloak admin password|adminpw||KEYCLOAK|
|FEASIBILITY_KEYCLOAK_PROXY_ADDR_FORWARDING|enables proxy forwarding in keyloak, which is required if a proxy like nginx is used|true||KEYCLOAK|
|FEASIBILITY_KEYCLOAK_BASE_URL|the base url used by keyloak. This has to be configured to the nginx url which forwards to keycloak if an nginx is used|https://localhost/auth||KEYCLOAK|