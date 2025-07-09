# The Fhir-Data-Evaluator (FDE)

The FDE is used as part of the feasibility triangle to collect metadata about available data on the local FHIR server.
This data can then be sent via the DSF to the central portal or loaded into the local portal to display the availability
of single criteria in the fhir server.

## Configuration

Copy the `.env.default` file to `.env` into this folder and change the env variables according to your requirements.


| Env Variable                                   | Description                                                    | Default                                   | Possible Values             |
|------------------------------------------------|----------------------------------------------------------------|-------------------------------------------|-----------------------------|
| FDE_INPUT_MEASURE                             | Path to the input measure JSON file                             | ./measure/kds-measure.json                | File path                   |
| FDE_OUTPUT_DIR                                | Directory to save output files                                  | ./output                                  | Directory path              |
| FDE_FHIR_SOURCE_SERVER                        | Base URL of the FHIR source server                              | http://localhost:8080/fhir                 | URL                         |
| FDE_FHIR_SOURCE_USER                          | Username for the FHIR source server authentication             | (empty)                                   | String                      |
| FDE_FHIR_SOURCE_PASSWORD                      | Password for the FHIR source server authentication             | (empty)                                   | String                      |
| FDE_FHIR_SOURCE_MAX_CONNECTIONS               | Maximum simultaneous connections to FHIR source server        | 4                                         | Integer                     |
| FDE_FHIR_SOURCE_PAGE_COUNT                    | Number of resources to fetch per page from FHIR source         | 1000                                      | Integer                     |
| FDE_FHIR_SOURCE_BEARER_TOKEN                  | Bearer token for FHIR source server authentication             | (empty)                                   | String                      |
| FDE_FHIR_SOURCE_OAUTH_ISSUER_URI              | OAuth issuer URI for FHIR source server                         | https://auth.localhost:444/realms/blaze   | URL                         |
| FDE_FHIR_SOURCE_OAUTH_CLIENT_ID               | OAuth client ID for FHIR source server                          | account                                   | String                      |
| FDE_FHIR_SOURCE_OAUTH_CLIENT_SECRET           | OAuth client secret for FHIR source server                      | insecure                                  | String                      |
| FDE_FHIR_REPORT_SERVER                        | Base URL of the FHIR report server                              | http://localhost:8080/fhir                 | URL                         |
| FDE_FHIR_REPORT_USER                          | Username for the FHIR report server authentication             | (empty)                                   | String                      |
| FDE_FHIR_REPORT_PASSWORD                      | Password for the FHIR report server authentication             | (empty)                                   | String                      |
| FDE_FHIR_REPORT_MAX_CONNECTIONS               | Maximum simultaneous connections to FHIR report server        | 4                                         | Integer                     |
| FDE_FHIR_REPORT_BEARER_TOKEN                  | Bearer token for FHIR report server authentication             | (empty)                                   | String                      |
| FDE_FHIR_REPORT_OAUTH_ISSUER_URI              | OAuth issuer URI for FHIR report server                         | https://auth.localhost:444/realms/blaze   | URL                         |
| FDE_FHIR_REPORT_OAUTH_CLIENT_ID               | OAuth client ID for FHIR report server                          | account                                   | String                      |
| FDE_FHIR_REPORT_OAUTH_CLIENT_SECRET           | OAuth client secret for FHIR report server                      | insecure                                  | String                      |
| FDE_MAX_IN_MEMORY_SIZE_MIB                    | Maximum size (MiB) of in-memory data storage                    | 10                                        | Integer                     |
| FDE_TZ                                        | Time zone to use for processing                                 | Europe/Berlin                             | Time zone                   |
| FDE_SEND_REPORT_TO_SERVER                     | Whether to send the generated report to the server             | true                                      | true, false                 |
| FDE_CREATE_OBFUSCATED_REPORT                  | Whether to create an obfuscated report                          | true                                      | true, false                 |
| FDE_AUTHOR_IDENTIFIER_SYSTEM                  | System URI for the author's identifier                          | http://dsf.dev/sid/organization-identifier | URL                      |
| FDE_AUTHOR_IDENTIFIER_VALUE                   | Value for the author's identifier                               | fde-dic                                   | String                      |
| FDE_PROJECT_IDENTIFIER_SYSTEM                 | System URI for the project's identifier                         | http://medizininformatik-initiative.de/sid/project-identifier | URL          |
| FDE_PROJECT_IDENTIFIER_VALUE                  | Value for the project's identifier                              | fdpg-data-availability-report             | String                      |
| FDE_PROJECT_IDENTIFIER_SYSTEM_OBFUSCATED_REPORT | System URI for obfuscated report's project identifier         | http://medizininformatik-initiative.de/sid/project-identifier | URL          |
| FDE_PROJECT_IDENTIFIER_VALUE_OBFUSCATED_REPORT | Value for obfuscated report's project identifier              | fdpg-data-availability-report-obfuscated  | String                      |


## Running the FDE

Run the FDE by executing the `run-fde` script provided here.

You can, as is configured by default, send the metadata report back to your FHIR server which contains your patient data
or alternatively send the data to a different fhir server. The metadata report is sent in the form of a FHIR resource of
type `MeasureReport` along with a `DocumentReference` FHIR resource.

Regardless of the choice, the FHIR server which contains the report should be accessible from your DSE BPE in order to 
send the report to the central FDPG DSF using the [data transfer plugin][data-transfer].

Note that the FDE creates to `MeasureReport` with respective `DocumentReference` on the target FHIR server.
Only the one with teh project identifier `fdpg-data-availability-report-obfuscated` should be send to the FDPG.


## Sending the report to the central portal

If you want to send the report to the central portal, you need to install and configure the data transfer plugin in your
DSE BPE according to the [data transfer plugin documentation][data-transfer-doc]. Then you follow the steps mentioned in
the documentation's section [DIC: Start Send Process][start-send-process] to send the report to the central portal. Use
the same project identifier as is configured in the FDE (`fdpg-data-availability-report-obfuscated` by default) and replace the DMS
organization identifier placeholder with the FDPG organization identifier `forschen-fuer-gesundheit.de`.


[data-transfer]:  https://github.com/medizininformatik-initiative/mii-process-data-transfer
[data-transfer-doc]:  https://github.com/medizininformatik-initiative/mii-process-data-transfer/wiki
[start-send-process]: https://github.com/medizininformatik-initiative/mii-process-data-transfer/wiki/Process-Data-Transfer-Start-v1.0.x.x#dic-start-send-process
