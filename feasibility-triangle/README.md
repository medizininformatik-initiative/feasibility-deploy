# The Feasibility Triangle


The Feasibility Triangle part of this repository provides a site (data integration center) with all the necessary components to set up in order to allow feasibility queries from the central feasibility portal.


## Overview

The Feasibility Triangle is composed of four components:

1. A Middleware Client (DSF)
2. A Feasibility Analysis Request Executor (FLARE)
3. A Dataselection and Extraction Executor (TORCH)
4. A FHIR Server (Blaze)
5. Reverse Proxy (NGINX)

The reverse proxy allows for integration into a site's multi-server infrastructure. It also provides basic auth capability for FHIR server and FLARE components.

### CQL Support

[CQL](https://cql.hl7.org) is supported. If your FHIR server **does not** support CQL itself then the FLARE component must be used as a kind of translation mediator.

### Component Interchangeability

All components work with well-defined interfaces making them interchangeable. Thus, there are different middleware clients and FHIR servers to chose from.

This leads to the following setup options:

- DSF - FLARE (FHIR Search) - FHIR Server (not CQL ready)
- DSF - FHIR Server (CQL ready)

**_When choosing a FHIR server, make sure it supports either CQL or the required FHIR search capabilities._**

## Setting up the Feasibility Triangle

### Step 1 - Installation Docker

The installation of the Feasibility Triangle requires Docker (https://docs.docker.com/engine/install/ubuntu/) and docker-compose (https://docs.docker.com/compose/install/).
If not already installed on your VM, install using the links provided above.

### Step 2 - Clone this Repository to your virtual machine

ssh to your virtual machine and switch to sudo `sudo -s`.
Designate a folder for your setup in which to clone the deploy repository, we suggest /opt (`cd /opt`)
Navigate to the directory and clone this repository: `git clone https://github.com/medizininformatik-initiative/feasibility-deploy.git`
Navigate to the feasibility-triangle folder of the repository: `cd /opt/feasibility-deploy/feasibility-triangle`
Checkout the version (git tag) of the feasibility triangle you would like to install: `git checkout <your-tag-name-here>`

### Step 3 - Initialise .env files

The feasibility portal requires .env files for the docker-compose setup. If you are performing a new setup of the project, execute the `initialise-triangle-env-files.sh`.

If you have set up the portal before compare the `.env` to the `.env.default` env files of each component and copy the additional params as appropriate.

### Step 4 - Set Up basic auth
To set up basic auth you can execute the `setup-base-auth.sh <username> <password>` to add a simple .htpasswd to protect your FHIR Server and FLARE component with basic authentication.
This creates a .htpasswd file in the `auth` directory, which will be mounted to the nginx, which is part of this deployment repository.

### Step 5 - Set Up ssl certificates

Running this setup safely at your site requires a valid certificate and domains. Please contact the responsible body of your institution to receive both domains and a certificate containing these domains as subject alternative names (SAN). The following services require a domain each:

- FHIR server
- FLARE
- TORCH
- Keycloak (optional, see step 8)

You will require two .pem files: a `cert.pem` (certificate) and `cert.key` (private key).

Once you have the appropriate certificates you should save them under `/opt/feasibility-deploy/feasibility-triangle/auth`.
Set the rights for all files of the auth folder to 655 `chmod 655 /opt/feasibility-deploy/feasibility-triangle/auth/*`.

- If you do not provide a cert.pem and cert.key file the reverse proxy will not start up, as it will not be able to provide a secure https connection.
- The rest of the feasibility triangle will still work, as it does create a connection to the outside without the need to make itself accessible.
- However, if you would for example load data into the FHIR server from an ETL job on another VM you will need to expose the FHIR server via a reverse proxy, which will require the certificates above.

### Step 6 - Create trust store for blaze

Generate a PKCS12 certificate file `./auth/trust-store.p12` containing the `cert.pem`
(see step 5 above). Running the script [generate-cert.sh](./generate-cert.sh) will generate the PKCS12
certificate file (and a self-signed `cert.pem` and `cert.key`, if these don't exist).

### Step 7 - Configure your feasibility triangle

> [!NOTE]
> All user env variables should be changed and all PASSWORD and SECRET variables should be set to secure passwords.

To configure the DSF middleware to connect to the triangle and the central feasibility portal follow the [DSF configuration wiki][1].

You need to configure the domains/hostnames in all env variables for the access from outside and for the OpenID Connect Provider
used for OAuth authentication against the BLAZE FHIR server, which is needed for logging into the BLAZE frontend. The domains/hostnames
correspond to the domain(s) covered by the ssl certificate you received in step 5.

For the reverse proxy you need to choose the configuration (variable `FEASIBILITY_TRIANGLE_REV_PROXY_NGINX_CONFIG` in
[rev-proxy/.env](./rev-proxy/.env)) which also decides what the changes to the `.env` files are you have to make:

- [./subdomains.nginx.conf](./rev-proxy/subdomains.nginx.conf) with separate domains for the services (fhir-server (incl) and optionally flare and keycloak)
  - All subdomains must point to the host machine the triangle will run on.
  - Set the service hostnames (`FLARE_HOSTNAME`, `FHIR_HOSTNAME`, `TORCH_HOSTNAME` and `KEYCLOAK_HOSTNAME`, depending on which services you need) in [rev-proxy/.env](./rev-proxy/.env).
  - You can change the default external port the reverse proxy listens on in [rev-proxy/.env](./rev-proxy/.env) (variable `FEASIBILITY_TRIANGLE_REV_PROXY_PORT`).
    Any value other than `443` needs to be added to all external url's in the `.env` files and to the url's used for accessing the triangle from outside.
    The default value is `444` to avoid a conflict with the proxy of the local feasibility portal when it is deployed on the same host.
  - Change the following variables in [fhir-server/.env](./fhir-server/.env):
    - `FHIR_SERVER_FRONTEND_KEYCLOAK_ENABLED`:
      - Set to `true` if you want to use the bundled keycloak.
        - `FHIR_SERVER_KC_HOSTNAME_URL`: set the domain part to the value you set for `KEYCLOAK_HOSTNAME` before and the port to the `REV_PROXY_PORT` set in [rev-proxy/.env](./rev-proxy/.env) (default `444`).
          The path must be set to `/` at the end of the url.
          For example, `https://auth.example.org:444/`.
        - `FHIR_SERVER_KC_HTTP_RELATIVE_PATH`: set to `/`.
      - Set to `false` to use none or your existing OpenID Connect provider.
    - `FHIR_SERVER_FRONTEND_ORIGIN`: set the domain part to the value you set for `FHIR_HOSTNAME` before and the port to the `REV_PROXY_PORT` set in [rev-proxy/.env](./rev-proxy/.env) (default `444`).
      For example, `https://fhir.example.org:444`.
  - Change the values for the variables `FLARE_FHIR_OAUTH_ISSUER_URI` in [flare/.env](./flare/.env) and `FHIR_SERVER_OPENID_PROVIDER_URL` in [fhir-server/.env](./fhir-server/.env)
    to the issuer url of your OpenID Connect provider.
    - When using the bundled keycloak replace the values with `https://KEYCLOAK_HOSTNAME:REV_PROXY_PORT/realms/blaze`
      where `KEYCLOAK_HOSTNAME` is the domain you set before and `REV_PROXY_PORT` is the port number set in [rev-proxy/.env](./rev-proxy/.env) (default `444`).
    - When using your own OpenID Connect provider replace the values the corresponding issuer url.
- [./context-paths.nginx.conf](./rev-proxy/subdomains.nginx.conf) which requires only one domain/hostname and uses context paths (`/` for flare,`/fhir` for fhir-server
  - The domain must point to the host machine the triangle will run on.
  - Change the following variables in [fhir-server/.env](./fhir-server/.env):
    - `FHIR_SERVER_FRONTEND_KEYCLOAK_ENABLED`:
      - Set to `true` if you want to use the bundled keycloak.
        - `FHIR_SERVER_KC_HOSTNAME_URL`: set the domain part to the value you set for `KEYCLOAK_HOSTNAME` before and the port to the `REV_PROXY_PORT` set in [rev-proxy/.env](./rev-proxy/.env) (default `444`).
          The path must be set to `/auth` at the end of the url.
          For example, `https://example.org:444/auth`.
        - `FHIR_SERVER_KC_HTTP_RELATIVE_PATH`: set to `/auth`.
      - Set to `false` to use none or your existing OpenID Connect provider.
    - `FHIR_SERVER_FRONTEND_ORIGIN`: set the domain part to your domain/hostname and the port to the `REV_PROXY_PORT` set in [rev-proxy/.env](./rev-proxy/.env) (default `444`).
      For example, `https://example.org:444`.
  - Change the values for the variables `FLARE_FHIR_OAUTH_ISSUER_URI` in [flare/.env](./flare/.env) and `FHIR_SERVER_OPENID_PROVIDER_URL` in [fhir-server/.env](./fhir-server/.env)
    to the issuer url of your OpenID Connect provider.
    - When using the bundled keycloak replace the values with `https://KEYCLOAK_HOSTNAME:REV_PROXY_PORT/auth/realms/blaze`
      where `KEYCLOAK_HOSTNAME` is your domain and `REV_PROXY_PORT` is the port number set in [rev-proxy/.env](./rev-proxy/.env) (default `444`).
      For example, `https://example.org:444/auth/realms/blaze`.
    - When using your own OpenID Connect provider replace the values with the corresponding issuer url.


> [!WARNING]
> The variable `FHIR_SERVER_BASE_URL=http://fhir-server:8080`should be kept as is for the standard setup, so that the UI can
> correctly access the blaze fhir server.

The triangle is configured by default to start the following services:

- FLARE: A Rest Service, which is needed to translate, execute and evaluate a feasibility query on a FHIR Server using FHIR Search
- TORCH: A Rest Service, which is needed to execute Dataselection and Extraction queries (CRTDLs - clinical-resource-transfer-definition-languge)
- BLAZE: The FHIR Server which holds the patient data for feasibility queries
- Keycloak (optional): OpenID Connect provider for authorization used by BLAZE component
  - We recommend using your own keyloak and configuring a blaze realm there

The bundled keycloak service is enabled by default and is preconfigured, so you only need to change passwords and
secrets in `/opt/feasibility-deploy/feasibility-triangle/fhir-server/.env` before starting the service.

If you want to use your own OpenID Connect provider you will need to set the correct issuer url and client credentials
in and disable the bundled keycloak service by setting environment variable `FHIR_SERVER_FRONTEND_KEYCLOAK_ENABLED`
to `false` in `/opt/feasibility-deploy/feasibility-triangle/fhir-server/.env`.

### Step 8 - Start the feasibility triangle

To start the triangle execute `/opt/feasibility-deploy/feasibility-triangle/start-triangle.sh`.

This starts the following default triangle:
FLARE (FHIR Search executor) - TORCH (FHIR Data Extractor) - BLAZE (FHIR Server) - Keycloak (optional)

If you would like to pick other component combinations you can start each component individually by setting your compose project (`export FEASIBILITY_COMPOSE_PROJECT=feasibility-deploy`)
navigating to the respective components folder and executing:
`-p $FEASIBILITY_COMPOSE_PROJECT up -d`


### Step 9 - Configure keycloak to create a user account in the realm blaze

> [!NOTE]
> The keycloak provided here is an example setup, and we strongly recommend for each site to adjust the keycloak installation to their local security requirements or connect the local feasibility portal to a keycloak already provided at the site.

 Navigate to the keycloak administration url which is the value of the variable `FHIR_SERVER_FRONTEND_KEYCLOAK_HOSTNAME_URL` in
[fhir-server/.env](./fhir-server/.env) (e.g. `https://auth.example.org:444/` or `https://example.org:444/auth` depending
on the nginx configuration used) and log into keycloak using the user `admin` and password set by the variable
`FHIR_SERVER_FRONTEND_KEYCLOAK_ADMIN_PASSWORD` in [fhir-server/.env](./fhir-server/.env). Both variables had to be setup
in step 7.

1. Set the domain for your client: Switch to the realm `blaze` (realm name might be different if you use your own keycloak) by using the realm changer on top of the left navigation bar (should be set to master when logging in).
2. Add a user for your realm `blaze`: Click on Users > Create new user and fill in the field Username with a username of your choice. Click on Credentials > Set Password and fill the Password and Password Confirmation fields with a password of your choice and save the changes by clicking set password.

### Step 10 - Access the Triangle

In the default configuration, and given that you have set up a SSL certificate in step 4, the setup will expose the following services:

These are the URLs for access to the webclients via nginx:

| Component   | URL                                                              | User             | Password         |
|-------------|------------------------------------------------------------------|------------------|------------------|
| Flare       | `https://your-flare-subdomain.your-domain:configured-port/`      | chosen in step 3 | chosen in step 3 |
| TORCH       | `https://your-torch-subdomain.your-domain:configured-port/`      | chosen in step 3 | chosen in step 3 |
| FHIR Server | `https://your-fhir-subdomain.your-domain:configured-port/fhir`   | chosen in step 3 | chosen in step 3 |

> [!NOTE]
> The subdomain part is relevant if you used the nginx configuration `subdomains.nginx.conf`, otherwise you just use
> `your-domain` for the url's.

> [!IMPORTANT]
> In order to access the frontend of the BLAZE FHIR Server you will need to use the keycloak user account in the realm
> `blaze` you created in step 9.

Accessible service via localhost:

| Component   | URL                              | Authentication Type | Notes                |
|-------------|----------------------------------|---------------------|----------------------|
| Flare       | <http://localhost:8084>          | None required       |                      |
| TORCH       | <http://localhost:8086>          | None required       |                      |
| FHIR Server | <http://localhost:8081/fhir>     | Bearer Token        | Configured in step 8 |

Please be aware that you will need to set up an ssh tunnel to your server and forward the respective ports if you would like to access the services on localhost without a password.

For example for the FHIR Server: ssh -L 8081:127.0.0.1:8081 your-username@your-server-ip


### Step 11 - Update your Blaze Search indices

If you are using the Blaze server provided in this repository check if new items have been added to the fhir-server/custom-search-parameters.json since your last update.
If new search parameters have been added follow the "fhir-server/README.md -> Re-indexing for new custom search parameters" section to update your FHIR server indices.

### Step 12 - Init Testdata (Optional)

To initialise testdata execute `get-mii-testdata.sh`. This will download MII core dataset compliant testdata from <https://github.com/medizininformatik-initiative/kerndatensatz-testdaten>,
unpack it and save it to the testdata folder of this repository.

You can then load the data into your FHIR Server using the `upload-testdata.sh` script. Before  executing the `upload-testdata.sh` if you're not using fhir.localhost set the FEASIBILITY_TESTDATA_UPLOAD_FHIR_BASE_URL variable to your FHIR_SERVER_HOSTNAME. 

## Updating the Feasibility Triangle

If you have already installed the feasibility triangle and just want to update it, follow these steps:

> [!NOTE]
> If you are upgrading to version >4.0.0 the structure of the project has changed significantly, as oauth was added to the Blaze FHIR server.
> We therefore ask you to follow the *Setting up the Feasibility Triangle* above


### Step 1 - Stop your triangle

`cd /opt/feasibility-deploy/feasibility-triangle && bash stop-triangle.sh`

### Step 2 - Update repository and check out new tag

`cd /opt/feasibility-deploy/feasibility-triangle && git pull`
`git checkout <new-tag>`

### Step 3 - transfer the new env variables

Compare the .env and .env.default files for each component and add any new variables from the .env.default file to the .env file.
Keep the existing configuration as is.

### Step 4 - Update your ontology

**Note:** The ontology is now part of the FLARE image and will not have to be loaded manually.

### Step 5 - Start your triangle

To start the triangle navigate to `/opt/feasibility-deploy/feasibility-triangle` and
execute `bash start-triangle.sh`.

### Step 6 - Update your DSF

If you are using the DSF to connect to the central feasibility portal, please follow the instructions in the [DSF configuration wiki][1].

### Step 7 - Log in to the central feasibility portal and test your connection

Ask for the Url of the central portal at the FDPG or check Confluence for the correct address.

Log in to the portal and send a request with the Inclusion Criterion chosen from the Inclusion criteria tree (folder sign under Inclusion Criteria)
"Person > PatientIn > Geschlecht: Female,Male"

and press "send".

Check your triangle DSF BPE App logs:
docker logs -f id-of-the-dsf-bpe-app-container

you should see output similar to:
```
Mar 29, 2023 12:59:57 PM feasibility.FeasibilityExecution doExecution
FINE: {"version":"http://to_be_decided.com/draft-1/schema#","display":"","inclusionCriteria":[[{"termCodes":[{"code":"263495000","system":"http://snomed.info/sct","display":"Geschlecht"}],"context":{"code":"Patient","system":"fdpg.mii.cds","version":"1.0.0","display":"Patient"},"valueFilter":{"selectedConcepts":[{"code":"female","display":"Female","system":"http://hl7.org/fhir/administrative-gender"},{"code":"male","display":"Male","system":"http://hl7.org/fhir/administrative-gender"}],"type":"concept"}}]]}
```

### Step 8 - Update your Blaze Search indices

If you are using the Blaze server provided in this repository check if new items have been added to the fhir-server/custom-search-parameters.json since your last update.
If new search parameters have been added follow the "fhir-server/README.md -> Re-indexing for new custom search parameters" section to update your FHIR server indices.

## Configuration

### Configurable environment variables

| Env Variable                                     | Description                                                                                                                                                     | Default                                       | Possible Values                                           | Component |
|--------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|-----------------------------------------------------------|-----------|
| FHIR_SERVER_BASE_URL                             | The base URL of the FHIR server the fhir server uses to generate next links                                                                                     | `http://fhir-server:8080`                     |                                                           | BLAZE     |
| FHIR_SERVER_LOG_LEVEL                            | log level of the FHIR server                                                                                                                                    | `debug`                                       | `debug`, `info` , `error`                                 | BLAZE     |
| BLAZE_JVM_ARGS                                   | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                       | `-Xmx4g`                                      |                                                           | BLAZE     |
| BLAZE_BLOCK_CACHE_SIZE                           | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                       | `256`                                         |                                                           | BLAZE     |
| BLAZE_DB_RESOURCE_CACHE_SIZE                     | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                       | `2000000`                                     |                                                           | BLAZE     |
| PORT_FHIR_SERVER_LOCALHOST                       | The exposed docker port of the FHIR server                                                                                                                      | `127.0.0.1:8081`                              | should always include 127.0.0.1                           | BLAZE     |
| FHIR_SERVER_OPENID_PROVIDER_URL                  | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                       | `https://auth.localhost:444/realms/blaze`     | URL                                                       | BLAZE     |
| FHIR_SERVER_OPENID_CLIENT_TRUST_STORE_PASS       | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                       | `insecure`                                    | secure password                                           | BLAZE     |
| FHIR_SERVER_FRONTEND_ORIGIN                      | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md#frontend                                                              | `https://fhir.localhost:444`                  |                                                           | BLAZE     |
| FHIR_SERVER_FRONTEND_AUTH_CLIENT_ID              | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md#frontend                                                              | `account`                                     |                                                           | BLAZE     |
| FHIR_SERVER_FRONTEND_AUTH_CLIENT_SECRET          | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md#frontend                                                              | `insecure`                                    | secure password                                           | BLAZE     |
| FHIR_SERVER_FRONTEND_AUTH_SECRET                 | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md#frontend                                                              | `insecure`                                    | secure password                                           | BLAZE     |
| FHIR_SERVER_FRONTEND_CA_CERT                     | Certificate PEM file containing the certificate of `cert.pem` or the certificate authority by which the `cert.pem` was signed                                   | `./auth/cert.pem`                             | host path                                                 | BLAZE     |
| FHIR_SERVER_FRONTEND_KEYCLOAK_ENABLED            | Enable/Disable automatic start of bundled Keycloak service executing `/opt/feasibility-deploy/feasibility-triangle/start-triangle.sh`                           | `true`                                        | `true` or `false`                                         | Keycloak  |
| FHIR_SERVER_KC_ADMIN_USER     | Keycloak admin user                                                                                                                                         | `admin`                                       | secure password                                           | Keycloak  |
| FHIR_SERVER_KC_ADMIN_PW     | Keycloak admin pw password                                                                                                                                         | `admin`                                       | secure password                                           | Keycloak  |
| FHIR_SERVER_KC_HOSTNAME_URL       | URL for accessing Keycloak via proxy                                                                                                                            | `https://fhir.localhost:444`                  |                                                           | Keycloak  |
| FHIR_SERVER_KC_HOSTNAME_ADMIN_URL       | URL for accessing Keycloak admin via proxy                                                                                                                            | `https://fhir.localhost:444`                  |                                                           | Keycloak  |
| FHIR_SERVER_KC_HTTP_RELATIVE_PATH | Relative path of Keycloak http service                                                                                                                          | `/`                                           | URL path                                                  | Keycloak  |
| FHIR_SERVER_KC_LOG_LEVEL          | Log level of Keycloak service                                                                                                                                   | `info`, `error`, `warn`, `info`, `debug`      |                                                           | Keycloak  |
| FHIR_SERVER_KC_DB          | db to be used for keycloak service                                                                                                                                   | string      |  keycloakdb                                                         | Keycloak  |
| FHIR_SERVER_KC_DB_USER          | db user to be used for keycloak service                                                                                                                                   | string      |  keycloakdbuser                                                         | Keycloak  |
| FHIR_SERVER_KC_DB_PW          | db pw to be used for keycloak service                                                                                                                                   | string      |  keycloakdbpw                                                         | Keycloak  |
| FHIR_SERVER_KC_HTTP_ENABLED          | enable http for keycloak service - required for the docker default setup                                                                                                                                   | string      |  keycloakdbpw                                                         | Keycloak  |
| FEASIBILITY_FLARE_PORT                           | The exposed docker port of the FLARE componenet                                                                                                                 | `127.0.0.1:8084`                              | should always include `127.0.0.1`                         | FLARE     |
| FLARE_ENABLED                                    | Enable/Disable automatic start of bundled Keycloak service executing `/opt/feasibility-deploy/feasibility-triangle/start-triangle.sh`                           | `true`                                        | `true` or `false`                                         | Keycloak  |
| FLARE_FHIR_SERVER_URL                            | The URL of the FHIR server FLARE uses to connect to the FHIR server                                                                                             | `http://fhir-server:8080/fhir/`               | URL                                                       | FLARE     |
| FLARE_FHIR_USER                                  | basic auth user to connect to FHIR server                                                                                                                       |                                               |                                                           | FLARE     |
| FLARE_FHIR_PW                                    | basic auth password to connect to FHIR server if CQL is used                                                                                                    |                                               |                                                           | FLARE     |
| FLARE_FHIR_PAGE_COUNT                            | The number of resources per page FLARE asks for from the FHIR server                                                                                            | `500`                                         |                                                           | FLARE     |
| FLARE_FHIR_MAX_CONNECTIONS                       | maximum number of connections flare will open to fhir server simultaniously                                                                                     | `32`                                          |                                                           | FLARE     |
| FLARE_CACHE_MEM_SIZE_MB                          | in memory cache size in mb                                                                                                                                      | `1024`                                        |                                                           | FLARE     |
| FLARE_CACHE_MEM_EXPIRE                           | in memory cache time to expire                                                                                                                                  | `PT48H`                                       | ISO 8601 time duration                                    | FLARE     |
| FLARE_CACHE_MEM_REFRESH                          | in memory chache time to refresh - not refresh should be shorter than expire                                                                                    | `PT24H`                                       | ISO 8601 time duration                                    | FLARE     |
| FLARE_CACHE_DISK_THREADS                         | number of threads used to write to disk cache                                                                                                                   | `4`                                           | integer                                                   | FLARE     |
| FLARE_CACHE_DISK_PATH                            | disk path for disk cache inside docker container                                                                                                                | `PT24H`                                       | string disk path                                          | FLARE     |
| FLARE_CACHE_DISK_EXPIRE                          | disk cache time to expire                                                                                                                                       | `P7D`                                         | ISO 8601 time duration                                    | FLARE     |
| FLARE_JAVA_TOOL_OPTIONS                          | java tool options passed to the flare container                                                                                                                 | `-Xmx4g`                                      |                                                           | FLARE     |
| FLARE_LOG_LEVEL                                  |                                                                                                                                                                 | `info`                                        | `off`, `fatal`, `error`, `warn`, `info`, `debug`, `trace` | FLARE     |
| FEASIBILITY_TRIANGLE_REV_PROXY_PORT              | The exposed docker port of the reverse proxy - set to 443 if you want to use standard https and you only have the feasibility triangle installed on your server | `444`                                         | Integer (valid port)                                      | REV Proxy |
| FHIR_SERVER_HOSTNAME 			           | change the default value of the domain names where the services are reachable                                                                                               | http://fhir-server:8080                       |                                                           | REV-PROXY |  
| KEYCLOAK_HOSTNAME                                | change the default value of the domain names where the services are reachable			                                                                             | https://keycloak.localhost:444/realms/blaze   |                                                           | REV-PROXY |  
| FLARE_HOSTNAME                                   |change the default value of the domain names where the services are reachable					                                                                           |  http://fhir-server:8080/fhir                 |                                                           | REV-PROXY |  
| TORCH_FHIR_URL                                   | The base URL of the FHIR server which contains the patient data Torch is used to extract.                                                                       | http://fhir-server:8080/fhir                  |                                                           | TORCH     |
| TORCH_FLARE_URL                                  | The base URL of the FLARE component if used.                                                                                                                    | http://flare:8080                             |                                                           | TORCH     |
| TORCH_RESULTS_PERSISTENCE                        |                                                                                                                                                                 | PT12H30M5S                                    |                                                           | TORCH     |
| TORCH_LOG_LEVEL                                  | Log level                                                                                                                                                       | debug                                         |                                                           | TORCH     |
| TORCH_BATCHSIZE                                  | The number of patients Torch processes in one batch.                                                                                                            | 500                                           |                                                           | TORCH     |
| TORCH_MAXCONCURRENCY                             | Maximum number of parallel threads Torch uses to process the data extractions.                                                                                  | 4                                             |                                                           | TORCH     |
| TORCH_USE_CQL                                    | Whether or not to use CQL - if false FLARE is used.                                                                                                             | true                                          |                                                           | TORCH     |
| TORCH_ENABLED                                    | Whether or not Torch should be started.                                                                                                                         | true                                          |                                                           | TORCH     |
| TORCH_BASE_URL                                   | Base Url of torch                                                                                                                                               | http://localhost:8080                         |                                                           | TORCH     |
| TORCH_OUTPUT_FILE_SERVER_URL                     | Url of the file server used to access the extracted data                                                                                                        | http://localhost                              |                                                           | TORCH     |
| TORCH_FHIR_USER                                  | FHIR basic auth user - leave empty if not needed                                                                                                                |                                               |                                                           | TORCH     |
| TORCH_FHIR_PASSWORD                              | FHIR basic auth pw - leave empty if not needed                                                                                                                  |                                               |                                                           | TORCH     |
| TORCH_FHIR_OAUTH_ISSUER_URI                      | oauth issuer uri  - leave empty if not needed                                                                                                                   |  ttps://auth.localhost:444/realms/blaze       |                                                           | TORCH     |
| TORCH_FHIR_OAUTH_CLIENT_ID                       | oauth client id   - leave empty if not needed                                                                                                                   |    account                                    |                                                           | TORCH     |
| TORCH_FHIR_OAUTH_CLIENT_SECRET                   | oauth client secret  - leave empty if not needed                                                                                                                |  insecure                                     |                                                           | TORCH     |
| TORCH_BUFFERSIZE                                 | Size for buffer (mb)                                                                                                                                            |  100                                          |                                                           | TORCH     |
| TORCH_JVM_ARGS                                   | jvm args - mainly used to configure memory usage                                                                                                                |  -Xmx8g                                       |                                                           | TORCH     |
| TORCH_FHIR_DISABLE_ASYNC                         | Enables or disables async fhir requests - (only enable (TORCH_FHIR_DISABLE_ASYNC = false) async if your FHIR Server supports it - for Blaze version >1.0.0)     |  true                                         |                                                           | TORCH     |
| TORCH_FHIR_MAX_CONNECTIONS                       | The maximum number of concurrent connections to the FHIR server  - has to be at least TORCH_MAXCONCURRENCY + 1                                                  |  5                                          |                                                           | TORCH     |
| TORCH_FHIR_PAGE_COUNT                            | FHIR page size                                                                                                                                                  |  500                                          |                                                           | TORCH     |
| TORCH_BUFFERSIZE                                 | Size for buffer (mb)                                                                                                                                            |  100                                          |                                                           | TORCH     |


### Support for self-singed certificates

Depending on your setup you might need to use self-singed certificates and the tools will have to accept your CAs.
For the triangle self-singed certificates are currently supported for the PATH: BPE (DSF) -> FLARE -> FHIR SERVER.

#### BPE (DSF)

The DSF Feasibility Plugin supports self-signed certificates - please see [DSF configuration wiki][1]
for details.

#### FLARE

FLARE supports the use of self-signed certificates from your own CAs. On each startup FLARE will search through the folder /app/certs inside the container , add all found CA `*.pem` files to a java truststore and start FLARE with this truststore.

In order to add your own CA files, add your own CA `*.pem` files to the `/app/certs` folder of the container.

Using docker-compose mount a folder from your host (e.g.: `./certs`) to the `/app/certs` folder, add your `*.pem` files (one for each CA you would like to support) to the folder and ensure that they have the .pem extension.


[1]: https://github.com/medizininformatik-initiative/feasibility-deploy/wiki/DSF-Middleware-Setup
