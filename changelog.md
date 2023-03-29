# Changelog

All notable changes to this project will be documented in this file.


## [2.0.0] - 2023-03-29

### Added


### Changed
- Limit amount of queries a user can post before being locked out ([#101](https://github.com/medizininformatik-initiative/feasibility-backend/pull/101))
- Query results are no longer persisted but only kept in memory for a configurable time ([#62](https://github.com/medizininformatik-initiative/feasibility-backend/pull/62)), ([#80](https://github.com/medizininformatik-initiative/feasibility-backend/pull/80)), ([#87](https://github.com/medizininformatik-initiative/feasibility-backend/pull/87))
- Return restricted results if certain thresholds are not surpassed ([#63](https://github.com/medizininformatik-initiative/feasibility-backend/pull/63)), ([#64](https://github.com/medizininformatik-initiative/feasibility-backend/pull/64))
### Removed
* Remove obsolete REST endpoints under /api/v1/ ([#109](https://github.com/medizininformatik-initiative/feasibility-backend/pull/109))
### Fixed
- Fix codesystem alias for consent ([#85](https://github.com/medizininformatik-initiative/feasibility-backend/pull/85)).
### Security
* Update Spring Boot to v3.0.5 ([#104](https://github.com/medizininformatik-initiative/feasibility-backend/pull/104))
* Update HAPI to 6.4.2 ([#73](https://github.com/medizininformatik-initiative/feasibility-backend/pull/73))

The full changelog can be found [here](https://github.com/medizininformatik-initiative/feasibility-backend/milestone/4?closed=1).