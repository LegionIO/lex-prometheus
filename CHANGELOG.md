# Changelog

## [0.1.2] - 2026-03-22

### Changed
- Add legion-cache, legion-crypt, legion-data, legion-json, legion-logging, legion-settings, and legion-transport as runtime dependencies
- Update spec_helper with real sub-gem helper stubs

## [0.1.0] - 2026-03-21

### Added
- Initial release
- `Helpers::Client` — Faraday connection builder with optional Basic auth
- `Runners::Queries` — instant_query, range_query, series, labels, label_values
- `Runners::Alerts` — list_alerts, list_rules
- Standalone `Client` class for use outside the Legion framework
