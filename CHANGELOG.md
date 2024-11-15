# Changelog

All notable changes to this project will be documented in this file.

## Component specific changes

Please refer to the respective repositories for a more in depth changelog of single components:

|Component|Link|
|--|--|
|UI|<https://github.com/medizininformatik-initiative/feasibility-gui>|
|Ontology Generation|<https://github.com/medizininformatik-initiative/fhir-ontology-generator>|
|sq2cql|<https://github.com/medizininformatik-initiative/sq2cql>|
|Backend|<https://github.com/medizininformatik-initiative/feasibility-backend>|
|DSF Feasibility Plugin|<https://github.com/medizininformatik-initiative/feasibility-dsf-process>|
|FLARE|<https://github.com/medizininformatik-initiative/flare>|
|TORCH|<https://github.com/medizininformatik-initiative/torch|
|Blaze FHIR server|<https://github.com/samply/blaze>|

## [5.0.0-alpha.1] - 2024-11-15

### Overall

- Updated all components to new versions
- Made FLARE execute-cohort endpoint only available on local docker network and new FLARE version makes enabling execute-cohort endpoint configurable


## [5.0.0-alpha] - 2024-10-21

### Features

| Feature | Affected Components |
| -- | -- |
|UI Re-Design, Restructuring of Code|UI, Backend|
|Extended Criteria Search (Elastic Search)|UI, Backend, Ontology Generation|
|Add OAuth2 to triangle components|TORCH, FLARE|
|Added Dataselection and Extraction |UI, Backend, Ontology Generation, TORCH|
|Migrated from Mapping code system tree strcture to poly tree structure to support non strict hierarchical code systems like sct |UI, Backend, Ontology Generation, TORCH, FLARE|
|Loading and displaying of criteria availability |UI, Backend, Ontology Generation|

### Overall

- Updated all components to new versions
- Added TORCH component for data selection and extraction in the triangle


## [4.1.0] - 2024-07-16

### Overall

- Changed to context configuration (installing using one domain) for default setup
- Added option to switch between subdomain and context setup


## [4.0.0] - 2024-07-01

### Overall

- Updated components and underlying libraries to the new versions and added new components:
  - Portal: gui `5.0.0`, backend `5.0.1`, keycloak `25.0`
  - Triangle:  flare `2.3.0`, blaze `0.28`, keycloak `25.0`
- Components above are based on ontology  ([2.2.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v2.2.0))
- Changed to subdomain configuration for default setup
- Separated portal webserver from UI for default deploy
- Removed AKTIN

### Features

| Feature | Affected Components |
| -- | -- |
|Improved support for referenced criteria|UI|
|Refactored Code Base|UI|
|Add OAuth2|DSF Feasibility Plugin|
|Add frontend|Blaze|
|Add dynamic indexing|Blaze|
|Add oAuth to direct broker for CQL|backend|

### Bugfix

| Bug | Affected Components |
| -- | -- |
|Fix Translation on Expanded Criteria with Reference Attribute Filters|sq2cql|
|Add Basic Auth to direct broker|backend|

### Removed

- Removed AKTIN support


## [3.2.0] - 2023-11-17

### Overall

- Updated gui, backend and flare components and underlying libraries to the new versions
- Adjusted readme to reflect changes in the underlying components and added Info about Blaze re-indexing
- Updated Ontology to newest version

### Bugfix

| Bug | Affected Components |
| -- | -- |
|Fixed consent querying|UI, backend, Ontology, sq2cql, FLARE, Blaze|
|Fixed CQL large query generation|sq2cql|
|Added newest missing search params to Blaze in this repository |Blaze|

## [3.1.0] - 2023-11-09

### Overall

- Updated all components and underlying libraries to the new versions
- Adjusted readme to reflect changes in the underlying components

### Features

| Feature | Affected Components |
| -- | -- |
|Improved support for referenced criteria|UI, backend, Ontology, sq2cql, FLARE, Blaze|
|Improved saving and loading of templates and saved queries|UI, backend|
|Make UI category order configurable|UI, backend|
|Improved Dataselection: added support for required criteria, allow selecting of any term tree node, |UI|
|Updated sq2cql to new ontology version|backend, sq2cql, Ontology, Blaze|
|Allow querying without value filter according to ontology ui_profiles optional attribute|UI, backend, Ontology|
|Improved error handling|UI, backend|


## [3.0.0] - 2023-10-08

### Overall

- Updated all components and underlying libraries to the new versions
- Updated all components to version compatible with ontology version 2.0
- Adjusted readme to reflect changes in the underlying components

### Features

| Feature | Affected Components |
| -- | -- |
|Added support for referenced criteria|UI, backend, Ontology, sq2cql, FLARE|
|Added support for composite search parameters|UI, SQ, Ontology, sq2cql, FLARE|
|Updated to new DSF version v1.0.0 compatible with new DSF verison v1.x | Backend, DSF feasibility plugin|
|Added Dateselection|UI|
|Update ontology to new ontology generation and added ontology to images directly| Ontology, Backend, FLARE|
|Added encrypted result logging| Backend|
|Add support for self-signed certificates| Backend, FLARE, DSF feasibility plugin |


## [2.1.0] - 2023-07-25

### Overall

- Updated AKTIN Client to 1.6.0: Fix websocket timeout and improve error handling  - <https://github.com/medizininformatik-initiative/feasibility-aktin-plugin/releases/tag/v1.6.0>
- Updated FLARE to 1.0: Fix Execution Operation - <https://github.com/medizininformatik-initiative/flare/releases/tag/v1.0.0>
- Updated Blaze to 0.22: implements $everything, adds basic frontend, Support for Custom Search Parameters <https://github.com/samply/blaze/releases/tag/v0.22.0>
- Added Troubleshooting specific for triangle
- Update testdata repo from MII


## [2.0.0] - 2023-03-29

### Overall

- Updated all components and underlying libraries to the new versions
- Updated UI to angular 15
- Updated keycloak to 21.0
- Updated nginx to 1.23
- Refactored deploy repository - removed DSF from this deployment and added reference to DSF deployment in Readme
- Removed hapi fhir-server from deployment

### Features

| Feature | Affected Components |
| -- | -- |
|Added calculated criterion age|Ontology, Sq2cql, FLARE|
|Improved at site obfuscation|DSF Feasibility Plugin, AKTIN Client|
|Added SQ query import and export|UI|
|Improved FHIR query execution and result caching |FLARE|
|Update Consent to new search params and add central MII consent query|UI, Ontology|
|Update ontology to newest KDS version| Ontology|
|Update AKTIN client to new version, move query handling to Java plugin and add query validation|AKTIN client|
|SQ query validation|Backend, AKTIN client|
|Add CQL execution to direct broker| Backend|

### Security and Privacy

| Feature | Affected Components |
| - | - |
|Added extra security measures, which restrict number queries a user can send and results a user can view|UI, Backend|
|Improved at site obfuscation|DSF Feasibility Plugin, Aktin Client|
|Hard rate limit at sites for AKTIN and DSF feasibility plugins|DSF feasibility plugin, AKTIN Client|
|Query results are no longer persisted and only kept in memory for a configurable amount of time|Backend|
|Delete query results from central DSF and AKTIN broker on collection|Backend|
|User blacklisting if too many queries are sent in a given time|Backend|

## [1.6.0] - 2022-09-08
