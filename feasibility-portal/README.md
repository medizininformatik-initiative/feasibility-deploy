# Feasibility Portal

The feasibility portal provides a feasibility query user interface with an appropriate backend, query translation to CQL and FHIR Search as well as 
the central part of two middlewares for the transfer of the queries from the feasibility portal to the feasibility triangles located at participating sites (hospitals).


## Setting up the Feasibility Portal - Local Installation

### Step 1 - Installation Docker

The installation of the Feasibility Portal requires Docker (https://docs.docker.com/engine/install/ubuntu/) and docker-compose (https://docs.docker.com/compose/install/).
If not already installed on your VM, install using the links provided above.

### Step 2 - Clone this Repository to your virtual machine

ssh to your virtual machine and switch to sudo `sudo -s`.
Designate a folder for your setup in which you clone the deploy repository, we suggest /opt (`cd /opt`)
Navigate to the directory and clone this repository: `git clone https://github.com/medizininformatik-initiative/feasibility-deploy.git`
Navigate to the feasibility-portal folder of the repository: `cd /opt/feasibility-deploy/feasibility-portal`
Checkout the version (git tag) of the feasibility portal you would like to install: `git checkout <your-tag-name-here>`

### Step 3 - Initialise .env files

The feasibility portal requires .env files for the docker-compose setup. If you are performing a new setup of the project, execute the `initialise-portal-env-files.sh`.

If you have set up the portal before, compare the .env to the .env.default env files of each component and copy the additional params as appropriate.

### Step 4 - Set up SSL certificates

Running this setup safely at your site requires a valid certificate and domain. Please contact the responsible body of your institution to receive both a domain and certificate.
You will require two .pem files: a cert.pem (certificate) and key.pem (private key).

Once you have the appropriate certificates you should save them under `/opt/feasibility-deploy/feasibility-portal/auth`.
Set the rights for all files of the auth folder to 655 `chmod 655 /opt/feasibility-deploy/feasibility-portal/auth/*`.  

- Not providing the certificate files is not an option.

### Step 5 - Load the ontology

**Note:** The ontology is now part of the image and will not have to be loaded manually.

### Step 6 - Configure your feasibility portal

If you use the default local feasibility portal setup you will only have to change the following environment variables:

| file                   | environment variable                       | value for local setup                                              |
|------------------------|--------------------------------------------|--------------------------------------------------------------------|
| keycloak/.env          | FEASIBILITY_KC_HOSTNAME_URL                | base-url-of-your-local-feasibility-portal                          |
| keycloak/.env          | FEASIBILITY_KC_HOSTNAME_ADMIN_URL          | base-url-of-your-local-feasibility-portal                          |
| keycloak/.env          | FEASIBILITY_KC_ADMIN_USER                  | keycloak admin user name                                           |
| keycloak/.env          | FEASIBILITY_KC_ADMIN_PW                    | choose a secure password here e.g. Ykc2PINWatNqL5Wq,OIxFz1Sv3dzmQ2 |
| backend/.env           | FEASIBILITY_BACKEND_AKTIN_ENABLED          | false                                                              |
| backend/.env           | FEASIBILITY_BACKEND_DIRECT_ENABLED         | true                                                               |
| backend/.env           | FEASIBILITY_BACKEND_API_BASE_URL           | base-url-of-your-local-feasibility-portal/api                      |
| backend/.env           | FLARE_WEBSERVICE_BASE_URL                  | http://flare:8080                                                  |
| backend/.env           | FEASIBILITY_BACKEND_ALLOWED_ORIGINS        | base-url-of-your-local-feasibility-portal                          |
|backend/.env            |FEASIBILITY_BACKEND_KEYCLOAK_BASE_URL_ISSUER| base-url-of-your-local-feasibility-portal                          |
| gui/deploy-config.json | uiBackendApi > baseUrl                     | base-url-of-your-local-feasibility-portal/api/v3                   |
| gui/deploy-config.json | auth > baseUrl                             | base-url-of-your-local-feasibility-portal                          |

Please note that all user env variables (variables containing USER) should be changed and all password variables (variables containing PASSWORD or PW) should be set to secure passwords.

For more details on the environment variables see the paragraph **Configurable environment variables** of this README.

### Step 7 - Start the feasibility portal

To start the portal navigate to `/opt/feasibility-deploy/feasibility-portal` and
execute `bash start-feasibility-portal-local.sh`.

This starts the following default local feasibility portal, with the following components:

| Component | url                                | description |
|-----------|------------------------------------|-------------|
| GUI       | https://my-fesibility-domain       |             |
| Keycloak  | https://my-feasibility-domain/auth |             |


### Step 8 - Configure keycloak and add a user for the user interface

Please note that the keycloak provided here is an example setup, and we strongly recommend for each site to adjust the keycloak installation to their local security requirements or connect the local feasibility portal to a keycloak already provided at the site.

Navigate to https://my-fesibility-domain/auth/keycloakadmin/admin
click on "Administration Console" and log in to keycloak using the admin user and password set in step 6 (FEASIBILITY_KC_ADMIN_USER, FEASIBILITY_KC_ADMIN_PW).
User: admin
Pw: my password set in step 6

1. Set the domain for your client:
Switch to the `feasibility` realm (realm name might be different if you use your own keycloak) by using the realm changer on top of the left navigation bar (should be set to `master` when logging in) 
Click on `Clients > feasibility-webapp` and change the fields: Root URL, Home URL and Web Origins
to: https://your-feasibility-domain  
      
    and **Valid Redirect URIs** to: https://your-feasibility-domain/*  

    and **Valid post logout redirect URIs** to: https://your-feasibility-domain/*

    and leave **Admin URL** empty

    Save the changes by clicking the "save" button.

2. Add a user for your feasibility user interface:
Click on `Users > Create new user` and fill in the field **Username** with a username of your choice.
Click on **Credentials** > **Set Password** and fill the `Password` and `Password Confirmation` fields with a password of your choice and save the changes by clicking `set password`.
Click on ** Role Mapping > Assign Role **  , select FeasibilityUser and click `Assign`


### Step 9 - Access the user interface and send first query

Access your user interface under <https://your-feasibility-domain> and log in with the user created in step 8.

Click on **New query**, create a query and send it using the **send** button.
After a few moments you should see the results to your query in the **Number of patients** window.


## Updating your local feasibility portal

If you have already installed the local feasibility portal and just want to update it, follow these steps:


### Step 1 - Stop your portal

`cd /opt/feasibility-deploy/feasibility-portal && bash stop-feasibility-portal.sh`

### Step 2 - Update repository and check out new tag

`cd /opt/feasibility-deploy && git pull`
`git checkout <new-tag>`

### Step 3 - transfer the new env variables

Compare the .env and .env.default files for each component and add any new variables from the .env.default file to the .env file.
Keep the existing configuration as is.

### Step 4 - Update your ontology

**Note:** The ontology is now part of the image and will not have to be loaded manually.

### Step 5 - Start your portal

To start the portal navigate to `/opt/feasibility-deploy/feasibility-portal` and
execute `bash start-feasibility-portal-local.sh`.

### Step 6 - Log in to the local feasibility portal and test your connection

Ask for the Url of the central portal at the FDPG or check Confluence for the correct address.

Log in to the portal and send a request with the Inclusion Criterion chosen from the Inclusion criteria tree (folder sign under Inclusion Criteria) 
"Person > PatientIn > Geschlecht: Female,Male"

and press "send".

## Configuration

### Configurable environment variables


| Env Var                                                                           | Description                                                                                                                                                                  | Default                                            | Possible values | Component |
|-----------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|-----------------|-----------|
| ### aktin config ###                                                              |                                                                                                                                                                              |                                                    |                 |           |
| AKTIN_BROKER_LOG_LEVEL                                                            | Log level of the aktin broker                                                                                                                                                | INFO                                               |                 | AKTIN     |
| AKTIN_ADMIN_PW                                                                    | password for the web admin of the aktin broker Admin is accessible via: http://localhost:AKTIN_BROKER_HOST_AND_PORT/admin/html/index.html                                    | changeme                                           |                 | AKTIN     |
| AKTIN_BROKER_HOST_AND_PORT                                                        | aktin broker Docker port                                                                                                                                                     | 127.0.0.1:8080                                     |                 | AKTIN     |
| ### backend db-config ###                                                         |                                                                                                                                                                              |                                                    |                 |           |
| FEASIBILITY_BACKEND_DATASOURCE_HOST                                               | backend database host                                                                                                                                                        | feasibility-gui-backend-db                         |                 | BACKEND   |
| FEASIBILITY_BACKEND_DATASOURCE_PORT                                               | backend database port                                                                                                                                                        | 5432                                               |                 | BACKEND   |
| FEASIBILITY_BACKEND_DATASOURCE_USERNAME                                           | backend database username                                                                                                                                                    | guidbuser                                          |                 | BACKEND   |
| FEASIBILITY_BACKEND_DATASOURCE_PASSWORD                                           | backend database password                                                                                                                                                    | guidbpw                                            |                 | BACKEND   |
| ### backend keycloak ###                                                          |                                                                                                                                                                              |                                                    |                 | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_ENABLED                                              | whether keycloak is enabled for the backend                                                                                                                                  | true                                               |                 | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_ALLOWED_ROLE                                         | The keycloak role required to access the backend                                                                                                                             | FEASIBILITY_USER                                   |                 | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_POWER_ROLE                                           | The keycloak role required to access the backend as Power user - Power users cannot be blacklisted                                                                           | FEASIBILITY_POWER_USER                             |                 | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_ADMIN_ROLE                                           | The keycloak role required to access the backend as admin                                                                                                                    | FEASIBILITY_ADMIN                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_BASE_URL_ISSUER                                      | the url the backend uses to access keycloak to verify the issuer                                                                                                             | 	http://keycloak:8080                              |                 | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_BASE_URL_JWK                                         | the url the backend uses to access keycloak for tokens                                                                                                                       | 	http://keycloak:8080                              |                 | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_REALM                                                | the realm the backend uses within keycloak                                                                                                                                   | codex-develop                                      |                 | BACKEND   |
| ### backend direct broker ###                                                     |                                                                                                                                                                              |                                                    |                 | BACKEND   |
| FEASIBILITY_BACKEND_BROKER_CLIENT_DIRECT_ENABLED                                  | enables the direct broker. This connects the backend directly to flare and is only meant to be used for a local installation                                                 | false                                              |                 | BACKEND   |
| FEASIBILITY_BACKEND_BROKER_CLIENT_DIRECT_USE_CQL                                  | tells the direct broker to use cql instead of flare for query execution                                                                                                      | false                                              |                 | BACKEND   |
| FEASIBILITY_BACKEND_BROKER_CLIENT_OBFUSCATE_RESULT_COUNT                          | obfuscate results from the local broker                                                                                                                                      | false                                              |                 | BACKEND   |
| FEASIBILITY_BACKEND_FLARE_WEBSERVICE_BASE_URL                                     | the url of the flare component the backend should connect to when using the direct broker                                                                                    | http://flare:8080                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_CQL_SERVER_BASE_URL                                           | the url of the fhir server the backend should connect to when using the direct broker                                                                                        | http://fhir-server:8080/fhir                       |                 | BACKEND   |
| ### backend Aktin broker ###                                                      |                                                                                                                                                                              |                                                    |                 | BACKEND   |
| FEASIBILITY_BACKEND_AKTIN_ENABLED                                                 | enables the aktin broker                                                                                                                                                     | false                                              |                 | BACKEND   |
| FEASIBILITY_BACKEND_AKTIN_BROKER_BASE_URL                                         | aktin broker base url                                                                                                                                                        | http://aktin-broker:8080/broker/                   |                 | BACKEND   |
| FEASIBILITY_BACKEND_AKTIN_BROKER_API_KEY                                          | aktin broker admin api key. The backend needs admin access as it requires permission to post new queries to the broker                                                       | xxxApiKeyAdmin123                                  |                 | BACKEND   |
| ### backend DSF broker ###                                                        |                                                                                                                                                                              |                                                    |                 | BACKEND   |
| FEASIBILITY_BACKEND_DSF_ENABLED                                                   | enables the dsf                                                                                                                                                              | false                                              |                 | BACKEND   |
| FEASIBILITY_BACKEND_DSF_CACERT                                                    |                                                                                                                                                                              | /opt/codex-feasibility-security/ca.pem             |                 | BACKEND   |
| FEASIBILITY_BACKEND_DSF_DSF_SECURITY_KEYSTORE_P12FILE                             |                                                                                                                                                                              | /opt/codex-feasibility-security/test-user.p12      |                 | BACKEND   |
| FEASIBILITY_BACKEND_DSF_SECURITY_KEYSTORE_PASSWORD                                |                                                                                                                                                                              | password                                           |                 | BACKEND   |
| FEASIBILITY_BACKEND_DSF_WEBSERVICE_BASE_URL                                       |                                                                                                                                                                              | https://dsf-zars-fhir-proxy/fhir                   |                 | BACKEND   |
| FEASIBILITY_BACKEND_DSF_WEBSOCKET_URL                                             |                                                                                                                                                                              | wss://dsf-zars-fhir-proxy:443/fhir/ws              |                 | BACKEND   |
| FEASIBILITY_BACKEND_DSF_ORGANIZATION_ID                                           |                                                                                                                                                                              | Test_ZARS                                          |                 | BACKEND   |
| ### backend privacy ###                                                           |                                                                                                                                                                              |                                                    |                 | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_SOFT_CREATE_AMOUNT                              | Set how many queries a user can send in a soft interval minutes time                                                                                                         | 3                                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_SOFT_CREATE_INTERVALMINUTES                     | Set how many minutes time within which user can send soft create amount                                                                                                      | 1                                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_HARD_CREATE_AMOUNT                              | Set how many queries a user can send in a hard interval minutes time - if exceeded user will be blacklisted                                                                  | 50                                                 |                 | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_HARD_CREATE_INTERVALMINUTES                     | Set how many minutes time within which user can send hard create amount - if exceeded user will be blacklisted                                                               | 10080                                              |                 | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_READ_SUMMARY_POLLINGINTERVALSECONDS             | Set polling interval for summary results - sum of results across all connected sites                                                                                         | 10                                                 |                 | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_READ_DETAILED_OBFUSCATED_POLLINGINTERVALSECONDS | Set polling interval for detailed obfuscated results - detailed list of results per site - site name obfuscated                                                              | 10                                                 |                 | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_READ_DETAILEDOBFUSCATED_AMOUNT                  | Set how often a user can view detailed obfuscated query results in DETAILEDOBFUSCATED_INTERVALSECONDS seconds                                                                | 3                                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_READ_DETAILEDOBFUSCATED_INTERVALSECONDS         | Set how many seconds time within which user can view detailed results DETAILEDOBFUSCATED_AMOUNT                                                                              | 7200                                               |                 | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_THRESHOLD_RESULTS                                     | Set results size which has to be exceeded for results to be shown                                                                                                            | 20                                                 |                 | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_THRESHOLD_SITES                                       | Set number of sites which have to be exceeded for results to be shown                                                                                                        | 3                                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_CERTS_PATH                                                    | path to certificates                                                                                                                                                         | ../dsf-broker/certs                                |                 | BACKEND   |
| FEASIBILITY_BACKEND_QUERYRESULT_EXPIRY_MINUTES                                    | The time it takes for query results to expire and be deleted                                                                                                                 | 5                                                  |                 | BACKEND   |
| ### backend logging ###                                                           |                                                                                                                                                                              |                                                    |                 | BACKEND   |
| FEASIBILITY_BACKEND_LOG_LEVEL_SQL                                                 | log level of the backend for hibernate                                                                                                                                       | info                                               |                 | BACKEND   |
| FEASIBILITY_BACKEND_LOG_LEVEL                                                     | log level of the backend                                                                                                                                                     | info                                               |                 | BACKEND   |
| ### backend app ###                                                               |                                                                                                                                                                              |                                                    |                 | BACKEND   |
| FEASIBILITY_BACKEND_CQL_TRANSLATE_ENABLED                                         | enables CQL translation                                                                                                                                                      | true                                               |                 | BACKEND   |
| FEASIBILITY_BACKEND_FHIR_TRANSLATE_ENABLED                                        | enables FHIR Search translation. This is only required if a site has their own FLARE component it wishes to use                                                              | false                                              |                 | BACKEND   |
| FEASIBILITY_BACKEND_API_BASE_URL                                                  | the api url of the backend. If using a reverse proxy this url should be the url of this proxy, which forwards to the backend                                                 | https://localhost/api/                             |                 | BACKEND   |
| FEASIBILITY_BACKEND_ALLOWED_ORIGINS                                               | base-url-of-your-local-feasibility-portal                                                                                                                                    | https://localhost                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_UI_PROFILES_PATH                                              | path on host where the backend searches for the ui profiles                                                                                                                  | ../ontology/ui_profiles                            |                 | BACKEND   |
| FEASIBILITY_BACKEND_CONCEPT_TREE_PATH                                             | path on host where the backend looks for the code tree file                                                                                                                  | ../ontology/codex-code-tree.json                   |                 | BACKEND   |
| FEASIBILITY_BACKEND_TERM_CODE_MAPPING_PATH                                        | path on host where the backend looks for the mapping file                                                                                                                    | ../ontology/codex-term-code-mapping.json           |                 | BACKEND   |
| FEASIBILITY_BACKEND_MIGRATION_PATH                                                | path on host where the backend looks for migration files                                                                                                                     | ../ontology/migration/R_Load_latest_ui_profile.sql |                 | BACKEND   |
| FEASIBILITY_BACKEND_ONTOLOGY_ORDER                                                | order in which the categories in the ui tree should be shown files                                                                                                                     | Diagnose, Prozedur, Person, Laboruntersuchung, Medikamentenverabreichung, Bioprobe, Einwilligung |                 | BACKEND   |
| FEASIBILITY_BACKEND_MAX_SAVED_QUERIES_PER_USER                                                | maximum queries a user can save with the overall result files                                                                                                                     | 100 |                 | BACKEND   |


| ### keycloak ###                                                                  |                                                                                                                                                                              |                                                    |                 |           |
| FEASIBILITY_KC_DB                                                                 | keycloak db name                                                                                                                                                             | keycloakdb                                         |                 | KEYCLOAK  |
| FEASIBILITY_KC_DB_USER                                                            | keycloak database username                                                                                                                                                   | keycloakdbuser                                     |                 | KEYCLOAK  |
| FEASIBILITY_KC_DB_PW                                                              | keycloak database password                                                                                                                                                   | keycloakdbpw                                       |                 | KEYCLOAK  |
| FEASIBILITY_KC_ADMIN_USER                                                         | keycloak admin username                                                                                                                                                      | admin                                              |                 | KEYCLOAK  |
| FEASIBILITY_KC_ADMIN_PW                                                           | keycloak admin password                                                                                                                                                      | adminpw                                            |                 | KEYCLOAK  |
| FEASIBILITY_KC_HTTP_RELATIVE_PATH                                                 | the relative path keycloak is running under                                                                                                                                  | /auth                                              |                 | KEYCLOAK  |
| FEASIBILITY_KC_HOSTNAME_URL                                                       | the url at which keycloak is exposed                                                                                                                                         | https://localhost/auth                             |                 | KEYCLOAK  |
| FEASIBILITY_KC_HOSTNAME_ADMIN_URL                                                 | the url of the admin console                                                                                                                                                 | https://localhost/auth/keycloakadmin               |                 | KEYCLOAK  |
| FEASIBILITY_KC_LOG_LEVEL                                                          | log level                                                                                                                                                                    | info                                               |                 | KEYCLOAK  |
| FEASIBILITY_KC_PROXY                                                              | type of proxy in front of keycloak to use                                                                                                                                    | edge                                               |                 | KEYCLOAK  |
| ### additional dsf configs ###                                                    |                                                                                                                                                                              |                                                    |                 |           |
| FEASIBILITY_DSF_BROKER_PROCESS_ORGANIZATION_IDENTIFIER                            | Identifier of this organization.                                                                                                                                             | Test_ZARS                                          | String          | DSF       |
| FEASIBILITY_DSF_BROKER_PROCESS_FHIR_SERVER_BASE_URL                               | Base URL to a FHIR server or proxy for feasibility evaluation. This can also be the base URL of a reverse proxy if used. Only required if evaluation strategy is set to cql. | https://dsf-zars-fhir-proxy/fhir                   | URL             | DSF       |
| ### Proxy configs - Environmental variables  ###                                                    |  

GUI_HOSTNAME     |    change the default value of the domain names where the services are reachable |   https://datenportal.localhost |      |   PROXY |  
KEYCLOAK_HOSTNAME |  change  the default value of the domain names where the services are reachable    | https://auth.datenportal.localhost    |      |    PROXY|  

BACKEND_HOSTNAME                                                | change  the default value of the domain names where the services are reachable                                                                                                                    | (https://api.datenportal.localhost) |                 | PROXY   |


### Support for self-signed certificates

Depending on your setup you might need to use self-singed certificates and the tools will have to accept your CAs.
For the portal then only tool for which this is relevant is the backend.

#### Feasibility Backend

The feasibility backend supports the use of self-signed certificates from your own CAs. On each startup, the feasibility backend will search through the folder /app/certs inside the container, add all found CA *.pem files to a java truststore and start the application with this truststore.

Using docker-compose, mount a folder from your host (e.g.: ./certs) to the /app/certs folder, add your *.pem files (one for each CA you would like to support) to the folder and ensure that they have the .pem extension.

In this deployment repository we have prepared this for you. To add your own CA add the respective ca *.pem files to the backend/certs folder.
