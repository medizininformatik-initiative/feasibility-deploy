# The Fhir-Data-Evaluator (FDE)

The FDE is used as part of the feasibility triangle to collect metadata about available data on the local FHIR server.
This data can then be sent via the DSF to the central portal or loaded into the local portal to display the availability
of single criteria in the fhir server.

## Configuration

Copy the `.env.default` file to `.env` into this folder and change the env variables according to your requirements.

| Env Variable                                    | Description                                                                                          | Default                                       | Possible Values                                 |
|-------------------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------------------------|-------------------------------------------------|
| FDE_CONVERT_TO_CSV                              | Whether to convert the data to CSV format                                                            | false                                         | true, false                                     |
| FDE_FHIR_SERVER                                 | Base URL of the FHIR server                                                                          | http://localhost:8080/fhir                    | URL                                             |
| FDE_FHIR_USER                                   | Username for the FHIR server authentication                                                          | (empty)                                       | String                                          |
| FDE_FHIR_PASSWORD                               | Password for the FHIR server authentication                                                          | (empty)                                       | String                                          |
| FDE_FHIR_MAX_CONNECTIONS                        | Maximum number of simultaneous connections to the FHIR server                                        | 4                                             | Integer                                         |
| FDE_FHIR_MAX_QUEUE_SIZE                         | Maximum size of the FHIR server request queue                                                        | 500                                           | Integer                                         |
| FDE_FHIR_PAGE_COUNT                             | Number of resources to fetch per page                                                                | 1000                                          | Integer                                         |
| FDE_FHIR_BEARER_TOKEN                           | Bearer token for FHIR server authentication                                                          | (empty)                                       | String                                          |
| FDE_FHIR_OAUTH_ISSUER_URI                       | OAuth issuer URI for FHIR server                                                                     | (empty)                                       | URL                                             |
| FDE_FHIR_OAUTH_CLIENT_ID                        | OAuth client ID for FHIR server                                                                      | (empty)                                       | String                                          |
| FDE_FHIR_OAUTH_CLIENT_SECRET                    | OAuth client secret for FHIR server                                                                  | (empty)                                       | String                                          |
| FDE_MAX_IN_MEMORY_SIZE_MIB                      | Maximum size (in MiB) of in-memory data storage                                                      | 10                                            | Integer                                         |
| FDE_INPUT_MEASURE                               | Path to the input measure JSON file                                                                  | ./measure/kds-measure.json                    | File path                                       |
| FDE_OUTPUT_DIR                                  | Directory to save output files                                                                       | ./output                                      | Directory path                                  |
| FDE_TZ                                          | Time zone to use for processing                                                                      | Europe/Berlin                                 | Time zone                                       |
| FDE_FHIR_REPORT_DESTINATION_SERVER              | FHIR server to send reports to                                                                       | http://localhost:8080/fhir                    | URL                                             |
| FDE_SEND_REPORT_TO_SERVER                       | Whether to send the generated report to the server                                                   | true                                          | true, false                                     |
| FDE_AUTHOR_IDENTIFIER_SYSTEM                    | System for the author's identifier                                                                   | http://dsf.dev/sid/organization-identifier    | URL                                             |
| FDE_AUTHOR_IDENTIFIER_VALUE                     | Value for the author's identifier                                                                    | fde-dic                                       | String                                          |
| FDE_PROJECT_IDENTIFIER_SYSTEM                   | System for the project's identifier                                                                  | http://medizininformatik-initiative.de/sid/project-identifier | URL                             |
| FDE_PROJECT_IDENTIFIER_VALUE                    | Value for the project's identifier                                                                   | fdpg-data-availability-report                 | String                                          |

## Running the FDE

Run the FDE by executing the `run-fde` script provided here.

You can, as is configured by default, send the metadata report back to your FHIR server which contains your patient data
or alternatively send the data to a different fhir server. The metadata report is sent in the form of a FHIR resource of
type `MeasureReport` along with a `DocumentReference` FHIR resource.

Regardless of the choice, the FHIR server which contains the report should be accessible from your DSE BPE in order to 
send the report to the central FDPG DSF using the [data transfer plugin][data-transfer].

## Sending the report to the central portal

If you want to send the report to the central portal, you need to install and configure the data transfer plugin in your
DSE BPE according to the [data transfer plugin documentation][data-transfer-doc]. Then you follow the steps mentioned in
the documentation's section [DIC: Start Send Process][start-send-process] to send the report to the central portal. Use
the same project identifier as is configured in the FDE (`fdpg-data-availability-report` by default) and replace the DMS
organization identifier placeholder with the FDPG organization identifier `forschen-fuer-gesundheit.de`.


[data-transfer]:  https://github.com/medizininformatik-initiative/mii-process-data-transfer
[data-transfer-doc]:  https://github.com/medizininformatik-initiative/mii-process-data-transfer/wiki
[start-send-process]: https://github.com/medizininformatik-initiative/mii-process-data-transfer/wiki/Process-Data-Transfer-Start-v1.0.x.x#dic-start-send-process
