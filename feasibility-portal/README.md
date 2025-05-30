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

### Step 5 - Configure your feasibility portal

If you use the default local feasibility portal setup you will only have to change the following environment variables:

| file                   | environment variable                       | value for local setup                                              |
|------------------------|--------------------------------------------|--------------------------------------------------------------------|
| keycloak/.env          | FEASIBILITY_KC_HOSTNAME_URL                | base-url-of-your-local-feasibility-portal-keycloak                 |
| keycloak/.env          | FEASIBILITY_KC_HOSTNAME_ADMIN_URL          | base-url-of-your-local-feasibility-portal-keycloak                 |
| keycloak/.env          | FEASIBILITY_KC_ADMIN_USER                  | keycloak admin user name                                           |
| keycloak/.env          | FEASIBILITY_KC_ADMIN_PW                    | choose a secure password here e.g. Ykc2PINWatNqL5Wq,OIxFz1Sv3dzmQ2 |
| backend/.env           | FEASIBILITY_BACKEND_DIRECT_ENABLED         | true                                                               |
| backend/.env           | FEASIBILITY_BACKEND_API_BASE_URL           | base-url-of-your-local-feasibility-portal-backend                  |
| backend/.env           | FLARE_WEBSERVICE_BASE_URL                  | http://flare:8080                                                  |
| backend/.env           | FEASIBILITY_BACKEND_ALLOWED_ORIGINS        | base-url-of-your-local-feasibility-portal-backend                  |
| backend/.env           |FEASIBILITY_BACKEND_KEYCLOAK_BASE_URL_ISSUER| base-url-of-your-local-feasibility-portal-keycloak                 |
| gui/deploy-config.json | uiBackendApi > baseUrl                     | base-url-of-your-local-feasibility-portal-backend/api/v3           |
| gui/deploy-config.json | auth > baseUrl                             | base-url-of-your-local-feasibility-portal-keycloak                 |
| proxy/.env.default	 | BACKEND_HOSTNAME                           | hostname (inkl. subdomain) of the local backend                    |
| proxy/.env.default     | KEYCLOAK_HOSTNAM                           | hostname (inkl. subdomain) of the local keycloak                   |
| proxy/.env.default     | GUI_HOSTNAME                               | hostname (inkl. subdomain) of the local ui                         |

Please note that all user env variables (variables containing USER) should be changed and all password variables (variables containing PASSWORD or PW) should be set to secure passwords.

To configure domain proxies, change the hostnames in the following environment variables in the file `/opt/feasibility-deploy/feasibility-portal/proxy/.env.default` according to the domains you possess.

The portal is configured by default to start the following services:

- Backend
- UI
- Keycloak

For the reverse proxy you need to choose the configuration (variable `FEASIBILITY_PORTAL_PROXY_NGINX_CONFIG` in
[proxy/.env](./proxy/.env)) which also decides what the changes to the `.env` files you have to make:

- [./subdomains.nginx.conf](./proxy/subdomains.nginx.conf) with separate domains for the services (Backend, UI, Keycloak)
  - All subdomains must point to the host machine the portal will run.

  - Set the service hostnames (`BACKEND_HOSTNAME`, `KEYCLOAK_HOSTNAME` and `GUI_HOSTNAME`, depending on which services you need) in [proxy/.env](./proxy/.env).
- Change the following variables in [keycloak/.env](./keycloak /.env):
      - `FEASIBILITY_KC_HOSTNAME_URL`and `FEASIBILITY_KC_HOSTNAME_ADMIN_URL`: set the domain part to the value you set for `KEYCLOAK_HOSTNAME` before.
      -` FEASIBILITY_KC_HTTP_RELATIVE_PATH`: set to `/auth`.
- Change the values for the variables `FEASIBILITY_BACKEND_API_BASE_URL` in [backend/.env](./backend/.env) and `FEASIBILITY_BACKEND_ALLOWED_ORIGINS` in [backend /.env](./backend/.env)
          to the base url of your feasibility portal backend. In the [backend/.env](./backend/.env) change the values for the variable `FEASIBILITY_BACKEND_KEYCLOAK_BASE_URL_ISSUER`	to the base url of your feasibility portal keycloak.
- Change the following variables in [gui/deploy-config.json](./gui/deploy-config.json):
      - `uiBackendApi > baseUrl`: set the domain part of the local feasibility portal backend.
      -  `auth > baseUrl`: set the domain part of the local feasibility portal keycloak.
- On the [proxy/.env] use this variable `FEASIBILITY_PORTAL_PROXY_NGINX_CONFIG=./subdomains.nginx.conf`.

- [./context-paths.nginx.conf](./proxy/context-paths.nginx.conf) which requires only one domain and uses context paths (`/auth` for keycloak,`/api` for backend and `/`) for user interface.
- The domain must point to the host machine the portal will run.
- On the [proxy/.env] use this variable`FEASIBILITY_PORTAL_PROXY_NGINX_CONFIG=./context-paths.nginx.conf`
-  Change the following variable `FEASIBILITY_KC_HOSTNAME_URL` and `FEASIBILITY_KC_HOSTNAME_ADMIN_URL` in [keycloak/.env]: set the domain part of your domain. The path must be set to /auth at the end of the url. For example, https://example.org/auth.
- Add `/auth` in the following variable `FEASIBILITY_KC_HTTP_RELATIVE_PATH` in [keycloak/.env]
- Change the following variable `FEASIBILITY_BACKEND_API_BASE_URL` in [backend/.env]: set the domain part of your domain. The path must be set to /api at the end of the url. For example, https://example.org/api.
- Change the following variable `FEASIBILITY_BACKEND_ALLOWED_ORIGINS`  in [backend/.env]: set the domain part of your domain. For example, https://example.org.
- Change the following variable`FEASIBILITY_BACKEND_KEYCLOAK_BASE_URL_ISSUER` in [backend/.env]: set the domain part of your domain. The path must be set to /api at the end of the url. For example, https://example.org/auth.
- Add `/auth` in the following variable `FEASIBILITY_BACKEND_KEYCLOAK_BASE_URL_JWK` in [backend/.env]
- Change the variable `FEASIBILITY_BACKEND_BROKER_CLIENT_DIRECT_AUTH_OAUTH_ISSUER_URL` when using the bundled keycloak in [backend/.env]replace the values with https://DOMAIN:REV_PROXY_PORT/auth/realms/blaze where DOMAIN is your domain and REV_PROXY_PORT is the port number set in rev-proxy/.env (default 444). For example, https://example.org:444/auth/realms/blaze.
- On the [gui/deploy-config.json] change the following variables:
  - `uiBackendApi > baseUrl`: set the domain part of the local feasibility portal backend with the context path `/api`. For example https://example.org/api.
  -  `auth > baseUrl`: set the domain part of the local feasibility portal keycloak the context path `/auth`. For example https://example.org/auth.

In case you do **not** have a docker-wide configuration of your organizations proxy server(s) you might need to add the following parameters to the `environment` section of the `init-elasticsearch` service in `backend/docker-compose.yml`: `HTTP_PROXY`, `HTTPS_PROXY` and `NO_PROXY`. The first two should obviously be your proxy server, the last one must include `dataportal-elastic`.

Please note that the keycloak provided here is an example setup, and we strongly recommend for each site to adjust the keycloak installation to their local security requirements or connect the local feasibility portal to a keycloak already provided at the site.

For more details on the environment variables see the paragraph **Configurable environment variables** of this README.

### Step 6 - Start the feasibility portal

To start the portal navigate to `/opt/feasibility-deploy/feasibility-portal` and
execute `bash start-feasibility-portal-local.sh`.

This starts the following default local feasibility portal, with the following components:

| Component | url                                                    | description |
|-----------|--------------------------------------------------------|-------------|
| GUI       | https://feasibility-subdomain.my-feasibility-domain    |             |
| Keycloak  | https://keycloak-subdomain.my-feasibility-domain       |             |
| Backend   | https://backend-subdomain.my-feasibility-domain/api/v5 |             |


### Step 7 - Configure keycloak and add a user for the user interface

Please note that the keycloak provided here is an example setup, and we strongly recommend for each site to adjust the keycloak installation to their local security requirements or connect the local feasibility portal to a keycloak already provided at the site.

Navigate to https://keycloak-subdomain.my-fesibility-domain/admin/master/console/
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


### Step 8 - Access the user interface and send first query

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

### Step 4 - Start your portal

To start the portal navigate to `/opt/feasibility-deploy/feasibility-portal` and
execute `bash start-feasibility-portal-local.sh`.

### Step 5 - Log in to the local feasibility portal and test your connection

Ask for the Url of the central portal at the FDPG or check Confluence for the correct address.

Log in to the portal and send a request with the Inclusion Criterion chosen from the Inclusion criteria tree (folder sign under Inclusion Criteria)
"Person > PatientIn > Geschlecht: Female,Male"

and press "send".

## Configuration

### Configurable environment variables


| Env Var                                                                           | Description                                                                                                                                                                  | Default                                            | Possible values | Component |
|-----------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|-----------------|-----------|
| ### backend db-config ###                                                         |                                                                                                                                                                              |                                                                                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_DATASOURCE_HOST                                               | backend database host                                                                                                                                                        | feasibility-gui-backend-db                                                                       | String          | BACKEND   |
| FEASIBILITY_BACKEND_DATASOURCE_PORT                                               | backend database port                                                                                                                                                        | 5432                                                                                             | Integer         | BACKEND   |
| FEASIBILITY_BACKEND_DATASOURCE_USERNAME                                           | backend database username                                                                                                                                                    | guidbuser                                                                                        | String          | BACKEND   |
| FEASIBILITY_BACKEND_DATASOURCE_PASSWORD                                           | backend database password                                                                                                                                                    | guidbpw                                                                                          | String          | BACKEND   |
| ### backend keycloak ###                                                          |                                                                                                                                                                              |                                                                                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_ENABLED                                              | whether keycloak is enabled for the backend                                                                                                                                  | true                                                                                             | Boolean         | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_ALLOWED_ROLE                                         | The keycloak role required to access the backend                                                                                                                             | FEASIBILITY_USER                                                                                 | String          | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_POWER_ROLE                                           | The keycloak role required to access the backend as Power user - Power users cannot be blacklisted                                                                           | FEASIBILITY_POWER_USER                                                                           | String          | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_ADMIN_ROLE                                           | The keycloak role required to access the backend as admin                                                                                                                    | FEASIBILITY_ADMIN                                                                                | String          | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_BASE_URL_ISSUER                                      | the url the backend uses to access keycloak to verify the issuer                                                                                                             | http://keycloak:8080                                                                             | URL             | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_BASE_URL_JWK                                         | the url the backend uses to access keycloak for tokens                                                                                                                       | http://keycloak:8080                                                                             | URL             | BACKEND   |
| FEASIBILITY_BACKEND_KEYCLOAK_REALM                                                | the realm the backend uses within keycloak                                                                                                                                   | codex-develop                                                                                    | String          | BACKEND   |
| ### backend direct broker ###                                                     |                                                                                                                                                                              |                                                                                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_BROKER_CLIENT_DIRECT_ENABLED                                  | enables the direct broker. This connects the backend directly to flare and is only meant to be used for a local installation                                                 | false                                                                                            | Boolean         | BACKEND   |
| FEASIBILITY_BACKEND_BROKER_CLIENT_DIRECT_USE_CQL                                  | tells the direct broker to use cql instead of flare for query execution                                                                                                      | false                                                                                            | Boolean         | BACKEND   |
| FEASIBILITY_BACKEND_BROKER_CLIENT_OBFUSCATE_RESULT_COUNT                          | obfuscate results from the local broker                                                                                                                                      | false                                                                                            | Boolean         | BACKEND   |
| FEASIBILITY_BACKEND_FLARE_WEBSERVICE_BASE_URL                                     | the url of the flare component the backend should connect to when using the direct broker                                                                                    | http://flare:8080                                                                                | URL             | BACKEND   |
| FEASIBILITY_BACKEND_CQL_SERVER_BASE_URL                                           | the url of the fhir server the backend should connect to when using the direct broker                                                                                        | http://fhir-server:8080/fhir                                                                     | URL             | BACKEND   |
| ### backend Aktin broker ###                                                      |                                                                                                                                                                              |                                                                                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_AKTIN_ENABLED                                                 | enables the aktin broker                                                                                                                                                     | false                                                                                            | Boolean         | BACKEND   |
| FEASIBILITY_BACKEND_AKTIN_BROKER_BASE_URL                                         | aktin broker base url                                                                                                                                                        | http://aktin-broker:8080/broker/                                                                 | URL             | BACKEND   |
| FEASIBILITY_BACKEND_AKTIN_BROKER_API_KEY                                          | aktin broker admin api key. The backend needs admin access as it requires permission to post new queries to the broker                                                       | xxxApiKeyAdmin123                                                                                | String          | BACKEND   |
| ### backend DSF broker ###                                                        |                                                                                                                                                                              |                                                                                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_DSF_ENABLED                                                   | enables the dsf                                                                                                                                                              | false                                                                                            | Boolean         | BACKEND   |
| FEASIBILITY_BACKEND_DSF_CACERT                                                    | filepath to mounted PEM encoded certificate containing certificate authorities                                                                                               | /opt/codex-feasibility-security/ca.pem                                                           | Path            | BACKEND   |
| FEASIBILITY_BACKEND_DSF_DSF_SECURITY_KEYSTORE_P12FILE                             | filepath to mounted PKCS#12 encoded keystore containing the DSF client certificate for authenticating against the DSF FHIR server                                            | /opt/codex-feasibility-security/test-user.p12                                                    | Path            | BACKEND   |
| FEASIBILITY_BACKEND_DSF_SECURITY_KEYSTORE_PASSWORD                                | password for reading PKCS#12 encoded keystore containing the DSF client certificate for authenticating against the DSF FHIR server                                           | password                                                                                         | String          | BACKEND   |
| FEASIBILITY_BACKEND_DSF_WEBSERVICE_BASE_URL                                       | DSF FHIR base url                                                                                                                                                            | https://dsf-zars-fhir-proxy/fhir                                                                 | URL             | BACKEND   |
| FEASIBILITY_BACKEND_DSF_WEBSOCKET_URL                                             | DSF FHIR websocket url                                                                                                                                                       | wss://dsf-zars-fhir-proxy:443/fhir/ws                                                            | URL             | BACKEND   |
| FEASIBILITY_BACKEND_DSF_ORGANIZATION_ID                                           | DSF organization identifier of the organization the backend instance is part of                                                                                              | Test_ZARS                                                                                        | String          | BACKEND   |
| ### backend privacy ###                                                           |                                                                                                                                                                              |                                                                                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_SOFT_CREATE_AMOUNT                              | Set how many queries a user can send in a soft time interval (ISO 8601 duration)                                                                                             | 3                                                                                                | Integer         | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_SOFT_CREATE_INTERVAL                            | Set how much time within which user can send soft create amount                                                                                                              | PT1M                                                                                             | Duration        | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_HARD_CREATE_AMOUNT                              | Set how many queries a user can send in a hard time interval - if exceeded user will be blacklisted                                                                          | 50                                                                                               | Integer         | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_HARD_CREATE_INTERVAL                            | Set how much time within which user can send hard create amount - if exceeded user will be blacklisted (ISO 8601 duration)                                                   | P7D                                                                                             | Duration        | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_READ_SUMMARY_POLLINGINTERVAL                    | Set polling interval for summary results - sum of results across all connected sites (ISO 8601 duration)                                                                     | PT10S                                                                                            | Duration        | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_READ_DETAILED_OBFUSCATED_POLLINGINTERVAL        | Set polling interval for detailed obfuscated results - detailed list of results per site - site name obfuscated (ISO 8601 duration)                                          | PT10S                                                                                            | Duration        | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_READ_DETAILEDOBFUSCATED_AMOUNT                  | Set how often a user can view detailed obfuscated query results in DETAILEDOBFUSCATED_INTERVAL time                                                                          | 3                                                                                                | Integer         | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_QUOTA_READ_DETAILEDOBFUSCATED_INTERVAL                | Set how much time within which user can view detailed results DETAILEDOBFUSCATED_AMOUNT (ISO 8601 duration)                                                                  | PT2H                                                                                             | Duration        | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_THRESHOLD_RESULTS                                     | Set results size which has to be exceeded for results to be shown                                                                                                            | 20                                                                                               | Integer         | BACKEND   |
| FEASIBILITY_BACKEND_PRIVACY_THRESHOLD_SITES                                       | Set number of sites which have to be exceeded for results to be shown                                                                                                        | 3                                                                                                | Integer         | BACKEND   |
| FEASIBILITY_BACKEND_CERTS_PATH                                                    | path to certificates                                                                                                                                                         | ../dsf-broker/certs                                                                              | Path            | BACKEND   |
| FEASIBILITY_BACKEND_QUERYRESULT_EXPIRY                                            | The time it takes for query results to expire and be deleted (ISO 8601 duration)                                                                                             | PT5M                                                                                             | Duration        | BACKEND   |
| ### backend logging ###                                                           |                                                                                                                                                                              |                                                                                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_LOG_LEVEL_SQL                                                 | log level of the backend for hibernate                                                                                                                                       | info                                                                                             | String          | BACKEND   |
| FEASIBILITY_BACKEND_LOG_LEVEL                                                     | log level of the backend                                                                                                                                                     | info                                                                                             | String          | BACKEND   |
| ### backend app ###                                                               |                                                                                                                                                                              |                                                                                                  |                 | BACKEND   |
| FEASIBILITY_BACKEND_CQL_TRANSLATE_ENABLED                                         | enables CQL translation                                                                                                                                                      | true                                                                                             | Boolean         | BACKEND   |
| FEASIBILITY_BACKEND_FHIR_TRANSLATE_ENABLED                                        | enables FHIR Search translation. This is only required if a site has their own FLARE component it wishes to use                                                              | false                                                                                            | Boolean         | BACKEND   |
| FEASIBILITY_BACKEND_API_BASE_URL                                                  | the api url of the backend. If using a reverse proxy this url should be the url of this proxy, which forwards to the backend                                                 | https://localhost/api/                                                                           | URL             | BACKEND   |
| FEASIBILITY_BACKEND_ALLOWED_ORIGINS                                               | base-url-of-your-local-feasibility-portal                                                                                                                                    | https://localhost                                                                                | URL             | BACKEND   |
| FEASIBILITY_BACKEND_UI_PROFILES_PATH                                              | path on host where the backend searches for the ui profiles                                                                                                                  | ../ontology/ui_profiles                                                                          | Path            | BACKEND   |
| FEASIBILITY_BACKEND_CONCEPT_TREE_PATH                                             | path on host where the backend looks for the code tree file                                                                                                                  | ../ontology/codex-code-tree.json                                                                 | Path            | BACKEND   |
| FEASIBILITY_BACKEND_TERM_CODE_MAPPING_PATH                                        | path on host where the backend looks for the mapping file                                                                                                                    | ../ontology/codex-term-code-mapping.json                                                         | Path            | BACKEND   |
| FEASIBILITY_BACKEND_MIGRATION_PATH                                                | path on host where the backend looks for migration files                                                                                                                     | ../ontology/migration/R_Load_latest_ui_profile.sql                                               | Path            | BACKEND   |
| FEASIBILITY_BACKEND_ONTOLOGY_ORDER                                                | order in which the categories in the ui tree should be shown files                                                                                                           | Diagnose, Prozedur, Person, Laboruntersuchung, Medikamentenverabreichung, Bioprobe, Einwilligung | String          | BACKEND   |
| FEASIBILITY_BACKEND_MAX_SAVED_QUERIES_PER_USER                                    | maximum queries a user can save with the overall result files                                                                                                                | 100                                                                                              | Integer         | BACKEND   |
| ### keycloak ###                                                                  |                                                                                                                                                                              |                                                                                                  |                 | KEYCLOAK  |
| FEASIBILITY_KC_DB                                                                 | keycloak db name                                                                                                                                                             | keycloakdb                                                                                       | String          | KEYCLOAK  |
| FEASIBILITY_KC_DB_USER                                                            | keycloak database username                                                                                                                                                   | keycloakdbuser                                                                                   | String          | KEYCLOAK  |
| FEASIBILITY_KC_DB_PW                                                              | keycloak database password                                                                                                                                                   | keycloakdbpw                                                                                     | String          | KEYCLOAK  |
| FEASIBILITY_KC_ADMIN_USER                                                         | keycloak admin username                                                                                                                                                      | admin                                                                                            | String          | KEYCLOAK  |
| FEASIBILITY_KC_ADMIN_PW                                                           | keycloak admin password                                                                                                                                                      | adminpw                                                                                          | String          | KEYCLOAK  |
| FEASIBILITY_KC_HTTP_RELATIVE_PATH                                                 | the relative path keycloak is running under                                                                                                                                  | /auth                                                                                            | String          | KEYCLOAK  |
| FEASIBILITY_KC_HOSTNAME_URL                                                       | the url at which keycloak is exposed                                                                                                                                         | https://localhost/auth                                                                           | URL             | KEYCLOAK  |
| FEASIBILITY_KC_HOSTNAME_ADMIN_URL                                                 | the url of the admin console                                                                                                                                                 | https://localhost/auth/keycloakadmin                                                             | URL             | KEYCLOAK  |
| FEASIBILITY_KC_LOG_LEVEL                                                          | log level                                                                                                                                                                    | info                                                                                             | String          | KEYCLOAK  |
| FEASIBILITY_KC_PROXY                                                              | type of proxy in front of keycloak to use                                                                                                                                    | edge                                                                                             | String          | KEYCLOAK  |
| ### additional dsf configs ###                                                    |                                                                                                                                                                              |                                                                                                  |                 | DSF       |
| FEASIBILITY_DSF_BROKER_PROCESS_ORGANIZATION_IDENTIFIER                            | Identifier of this organization.                                                                                                                                             | Test_ZARS                                                                                        | String          | DSF       |
| FEASIBILITY_DSF_BROKER_PROCESS_FHIR_SERVER_BASE_URL                               | Base URL to a FHIR server or proxy for feasibility evaluation. This can also be the base URL of a reverse proxy if used. Only required if evaluation strategy is set to cql. | https://dsf-zars-fhir-proxy/fhir                                                                 | URL             | DSF       |
| ### Proxy configs ###                                                             |                                                                                                                                                                              |                                                                                                  |                 | PROXY     |
| GUI_HOSTNAME                                                                      | change the default value of the domain name where the gui service is reachable                                                                                               | https://datenportal.localhost                                                                    | URL             | PROXY     |
| KEYCLOAK_HOSTNAME                                                                 | change the default value of the domain name where the keycloak service is reachable                                                                                          | https://auth.datenportal.localhost                                                               | URL             | PROXY     |
| BACKEND_HOSTNAME                                                                  | change the default value of the domain name where the backend service is reachable                                                                                           | https://api.datenportal.localhost                                                                | URL             | PROXY     |


### Support for self-signed certificates

Depending on your setup you might need to use self-singed certificates and the tools will have to accept your CAs.
For the portal then only tool for which this is relevant is the backend.

#### Feasibility Backend

The feasibility backend supports the use of self-signed certificates from your own CAs. On each startup, the feasibility backend will search through the folder /app/certs inside the container, add all found CA *.pem files to a java truststore and start the application with this truststore.

Using docker-compose, mount a folder from your host (e.g.: ./certs) to the /app/certs folder, add your *.pem files (one for each CA you would like to support) to the folder and ensure that they have the .pem extension.

In this deployment repository we have prepared this for you. To add your own CA add the respective ca *.pem files to the backend/certs folder.
