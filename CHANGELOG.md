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
|TORCH|<https://github.com/medizininformatik-initiative/torch>|
|Blaze FHIR server|<https://github.com/samply/blaze>|
|Fhir Data Evaluator|<https://github.com/medizininformatik-initiative/fhir-data-evaluator>|


## [5.4.0] - 2025-07-24


### Ontology

Changed FROM [v3.7.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.7.0) to [v3.8.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.8.0)

#### Major Ontology Updates

* Update display generation for value definitions of criteria by @paulolaup in https://github.com/medizininformatik-initiative/fhir-ontology-generator/pull/289
* Implement Cause of Death criteria class for cohort selection ontology by @paulolaup in https://github.com/medizininformatik-initiative/fhir-ontology-generator/pull/290


### Updates since last Major

|Component|From|To|
|--|--|--|
|UI|[v6.2.0](https://github.com/medizininformatik-initiative/feasibility-gui/releases/tag/v6.2.0)|[v6.3.3](https://github.com/medizininformatik-initiative/feasibility-gui/releases/tag/v6.3.3)|
|Backend|[v7.1.1](https://github.com/medizininformatik-initiative/feasibility-backend/releases/tag/v7.1.1)|[v7.3.0](https://github.com/medizininformatik-initiative/feasibility-backend/releases/tag/v7.3.0)|
|Blaze|[v1.0.0](https://github.com/samply/blaze/releases/tag/v1.0.0)|[v1.0.4](https://github.com/samply/blaze/releases/tag/v1.0.4)|
|Keycloak|keycloak/keycloak:26.2|quay.io/keycloak/keycloak:26.3.1|
|TORCH|[1.0.0-test2](https://github.com/medizininformatik-initiative/torch/releases/tag/v1.0.0-test2)|[1.0.0-alpha.6](https://github.com/medizininformatik-initiative/torch/releases/tag/v1.0.0-alpha.6)|
|FLARE|[2.5.0](https://github.com/medizininformatik-initiative/flare/releases/tag/v2.5.0)|[2.6.0](https://github.com/medizininformatik-initiative/flare/releases/tag/v2.6.0)|
|FDE|[1.2.0](https://github.com/medizininformatik-initiative/fhir-data-evaluator/releases/tag/v1.2.0)|[1.3.1](https://github.com/medizininformatik-initiative/fhir-data-evaluator/releases/tag/v1.3.1)|


### Major Changes since last Major

#### UI

* Preloaded criteria filter, criteria search results and data selection profiles before page load using Angular route resolver [#415](https://github.com/medizininformatik-initiative/feasibility-gui/issues/415)
* **About Page** with system version information (UI, Backend, Ontology) [#403](https://github.com/medizininformatik-initiative/feasibility-gui/issues/403)
* Updated **language files** in `src/assets/i18n` [#393](https://github.com/medizininformatik-initiative/feasibility-gui/issues/393), [#399](https://github.com/medizininformatik-initiative/feasibility-gui/issues/399), [#400](https://github.com/medizininformatik-initiative/feasibility-gui/issues/400)
* Change download behaviour of Cohort selection ([#395](https://github.com/medizininformatik-initiative/feasibility-gui/issues/395))
* Query without data selection is not saveable anymore ([#396](https://github.com/medizininformatik-initiative/feasibility-gui/issues/396))
* Fix for mandatory patient feature is added to DSE on query load ([#394](https://github.com/medizininformatik-initiative/feasibility-gui/issues/394))
* Checkbox for "Only if referenced" is only be visible if feature is referenced ([#397](https://github.com/medizininformatik-initiative/feasibility-gui/issues/397))

#### Backend

* #523  - Admin user should be able to read all queries by @michael-82 in https://github.com/medizininformatik-initiative/feasibility-backend/pull/524
* #516 - provide export of CQL "translation" by @michael-82 in https://github.com/medizininformatik-initiative/feasibility-backend/pull/528
* #537 - Move openai documentation to default api path by @michael-82 in https://github.com/medizininformatik-initiative/feasibility-backend/pull/538
* Implement FHIR Async Request Pattern for Direct Broker using CQL by @EmteZogaf in https://github.com/medizininformatik-initiative/feasibility-backend/pull/539
* #544 - Move cql config parameters in application yml by @michael-82 in https://github.com/medizininformatik-initiative/feasibility-backend/pull/545
* #540 - Resultsize missing in dataquery list via by-user endpoint by @michael-82 in https://github.com/medizininformatik-initiative/feasibility-backend/pull/541

#### Keycloak

* Changed from Keycloak image to quay.io image to ensure use of the official, up-to-date container maintained by the Keycloak team.

#### Blaze

* Fix Consent Resource policyRule Property ([#2700](https://github.com/samply/blaze/issues/2700))
* Support Resolving Relative References in Transaction Bundles ([#2734](https://github.com/samply/blaze/issues/2734))
* Search for text/cql Content in Library ([#2718](https://github.com/samply/blaze/issues/2718))
* Fix Query Sort in CQL ([#1315](https://github.com/samply/blaze/issues/1315))

#### TORCH

* First alpha Version release, which is released as part of the deployment
* For features see TORCH Wiki

#### FLARE

* Update Ontology to v3.8.0 ([#294](https://github.com/medizininformatik-initiative/flare/issues/294))

#### FDE - Fhir-Data-Evaluator

* Add backpressure handling
* Add additional logging
* Add Option to Obfuscate Stratifier Results

## [5.3.4] - 2025-06-20

**minor fixes in v5.3.4**

- Backend:
  - Fix admin user was not able to read all queries

### Ontology

This release is based on ontology version [v3.7.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.7.0)

### Updates to

- Blaze to [1.0.2](https://github.com/samply/blaze/releases/tag/v1.0.2)
- TORCH to [1.0.0-alpha.5](https://github.com/medizininformatik-initiative/torch/releases/tag/v1.0.0-alpha.5)


## [5.3.3] - 2025-06-06

**minor fixes in v5.3.3**

- Backend:
  - Fix admin user was not able to read all queries

### Ontology

This release is based on ontology version [v3.7.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.7.0)

### Updates to

- backend to [v7.1.2](https://github.com/medizininformatik-initiative/feasibility-backend/releases/tag/v7.1.2)


## [5.3.2] - 2025-05-30

**minor fixes in v5.3.2**

- Backend:
  - Fix interval syntax error

### Ontology

This release is based on ontology version [v3.7.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.7.0)


## [5.3.1] - 2025-05-30

**minor fixes in v5.3.1**

- GUI:
  - Add missing PatientProfile URL in deploy configuration

### Ontology

This release is based on ontology version [v3.7.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.7.0)


## [5.3.0] - 2025-05-28

**minor fixes in v5.3.0**

- Backend:
  - Fix - creating dataquery with filterdate causes error
  - Fix - reading the crtdl part of a dataquery without cohortDefinition fails
  - Fix - error reading query list
  - Fix - missing Display Information for Parents and Children
- GUI:
  - Increased ElasticSearch visualization limit from 20 to 50 matches
  - Adjusted CSS for indentation in tree view
  - Switch date display to european format

### New Features

- Backend:
  - Extend api to save and load cohort and dataselection
  - Generate crtdl csv file
  - Change configurable time intervals to ISO 8601 durations
- GUI:
  - New save dialog with checkboxes for cohort and data selection
  - Added new editor pages for Criterion and Profile
  - Added support for single feature patient profiles
  - Implemented loading of reference profile lists
  - Switch to backend API v5

### Ontology

This release is based on ontology version [v3.7.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.7.0)

### Updates to

- backend to [v7.1.1](https://github.com/medizininformatik-initiative/feasibility-backend/releases/tag/v7.1.1)
- ontology to [v3.7.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.7.0)
- UI to [v6.2.0](https://github.com/medizininformatik-initiative/feasibility-gui/releases/tag/v6.2.0)
- Blaze to [v1.0.0](https://github.com/samply/blaze/releases/tag/v1.0.0)


## [5.2.4] - 2025-03-21

**minor fixes in v5.2.4**

- GUI:
  - Prevent constant openings of modal after downloading query

### Ontology

This release is based on ontology version [v3.2.2](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.2.2)

### Updates to

- UI to [v6.0.10](https://github.com/medizininformatik-initiative/feasibility-gui/releases/tag/v6.0.10)


## [5.2.3] - 2025-03-19

### Special notes

Set UI to previously stable version 6.0.6 (https://github.com/medizininformatik-initiative/feasibility-gui/releases/tag/v6.0.6)

### Ontology

This release is based on ontology version [v3.2.2](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.2.2)

### Updates to

- backend to [v6.2.2](https://github.com/medizininformatik-initiative/feasibility-backend/releases/tag/v6.2.2)
- ontology to [v3.2.2](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.2.2)
- blaze frontend to match server version, bot to [0.33](https://github.com/samply/blaze/tree/v0.33.0)

### Downgrades

- UI to 6.0.6 (https://github.com/medizininformatik-initiative/feasibility-gui/releases/tag/v6.0.6)


## [5.2.2] - 2025-03-18

**minor fixes**

- Ontology:
  - Fix - do not set reference fields as recommended for data selection

### Ontology

This release is based on ontology version [v3.2.2](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.2.2)

### Updates to

- backend to [v6.2.2](https://github.com/medizininformatik-initiative/feasibility-backend/releases/tag/v6.2.2)
- ontology to [v3.2.2](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.2.2)


## [5.2.1] - 2025-03-17

**minor fixes in v5.2.1**

- Ontology:
  - Revert changes in FHIRSearch mapping to fix incompatibility with FLARE

### Ontology

This release is based on ontology version [v3.2.1](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.2.1)

### Updates to

- backend to [v6.2.1](https://github.com/medizininformatik-initiative/feasibility-backend/releases/tag/v6.2.1)
- ontology to [v3.2.1](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.2.1)


## [5.2.0] - 2025-03-14

**minor fixes in v5.2.0**

- GUI:
  - Details counter gets incremented correctly
  - Combined consent is set in downloaded CCDL
- Backend:
  - Encounter Module fixed by fixed typing in ontology

### New Features

- Backend:
  - Provide an endpoint for version information, accessible at path `/actuator/info`
- GUI:
  - Translation for consent text

### Ontology

This release is based on ontology version [v3.2.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.2.0)

### Updates to

- backend to [v6.2.0](https://github.com/medizininformatik-initiative/feasibility-backend/releases/tag/v6.2.0) and within sq2cql to [v1.0.0](https://github.com/medizininformatik-initiative/sq2cql/releases/tag/v1.0.0)
- ontology to [v3.2.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.2.0)
- UI to [v6.0.8](https://github.com/medizininformatik-initiative/feasibility-gui/releases/tag/v6.0.8)
- Blaze to [v0.33](https://github.com/samply/blaze/releases/tag/v0.33.0)


## [5.1.1] - 2025-03-03

**minor fixes in v5.1.1**

- Backend Bugfixes: Improve elastic search query for better results, fix initial counter value of remaining result details views

### known bugs

- Encounter Module faulty at sq2cql translation and therefore non functioning (CQL)

### Ontology

This Release is based on ontology Version [v3.1.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.1.0)

### Updates to

- backend


## [5.1.0] - 2025-02-18

**minor fixes in v5.1.0**

- sq2cql and ontology were updated to handle time restrictions by type correctly
- UI Bugfixes: Remove hashes from feasibility detail results, Fixed error message display, Resolve inconsistency between summary and details results

### New Features

- Added translations
- Added new CDS modules to dataselection - see ontology release

### known bugs

- Encounter Module faulty at sq2cql translation and therefore non functioning (CQL)

### Ontology

This Release is based on ontology Version [v3.1.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.1.0)

### Updates to

- backend and within sq2cql
- ontology
- UI


## [5.0.2] - 2025-02-03

**minor fixes in v5.0.2**

- sq2cql was updated to handle consent MedicationStatement and MedicationRequest correctly

### known bugs

- Encounter Module faulty at sq2cql translation and therefore non functioning (CQL)

### Ontology

This Release is based on ontology Version [v3.0.1](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.0.1)

### no updates to

- Everything except backend


## [5.0.1] - 2024-12-18

**minor fixes in v5.0.1**

- Ontology contained multiple instances of the same codes but lacked others -> fixed, v3.0.1
- sq2cql was updated to handle consent correctly
- UI was unable to save cohort selections -> fixed

### known bugs

- Encounter Module faulty at sq2cql translation and therefore non functioning (CQL)
- Medication Statement, Medication request faulty at sq2cql level and therefore non functioning (CQL)

### Ontology

This Release is based on ontology Version [v3.0.1](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.0.1)
Flare contains new ontology

### no updates to

- Torch
- FDE


## [5.0.0] - 2024-11-21

### Ontology

This Release is based on ontology Version [v3.0.0](https://github.com/medizininformatik-initiative/fhir-ontology-generator/releases/tag/v3.0.0)


### Overall

- Updated all components to new versions
- Made FLARE execute-cohort endpoint only available on local docker network and new FLARE version makes enabling execute-cohort endpoint configurable
- Added Fhir-Data-Evaluator (FDE) to triangle

### Features

| Feature | Affected Components |
| -- | -- |
|UI Re-Design, Restructuring of Code|UI, Backend|
|Extended Criteria Search (Elastic Search)|UI, Backend, Ontology Generation|
|Add OAuth2 to triangle components|TORCH, FLARE|
|Added Dataselection and Extraction |UI, Backend, Ontology Generation, TORCH|
|Migrated from Mapping code system tree strcture to poly tree structure to support non strict hierarchical code systems like sct |UI, Backend, Ontology Generation, TORCH, FLARE|
|Loading and displaying of criteria availability |UI, Backend, Ontology Generation|
|Added new modules and Updated Ontology|UI, Backend, Ontology Generation, FLARE, sq2cq, TORCH|


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
