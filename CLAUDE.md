# lex-prometheus: Prometheus Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to Prometheus via the HTTP API v1. Provides runners for instant and range queries, series metadata, label inspection, alerts, and rules.

**GitHub**: https://github.com/LegionIO/lex-prometheus
**License**: MIT
**Version**: 0.1.0

## Architecture

```
Legion::Extensions::Prometheus
├── Runners/
│   ├── Queries  # instant_query, range_query, series, labels, label_values
│   └── Alerts   # list_alerts, list_rules
├── Helpers/
│   └── Client   # Faraday connection (Prometheus HTTP API v1, optional Basic Auth)
└── Client       # Standalone client class (includes all runners)
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/prometheus.rb` | Entry point, extension registration |
| `lib/legion/extensions/prometheus/runners/queries.rb` | PromQL instant/range query, series, label runners |
| `lib/legion/extensions/prometheus/runners/alerts.rb` | Alert and rule listing runners |
| `lib/legion/extensions/prometheus/helpers/client.rb` | Faraday connection builder (optional Basic Auth) |
| `lib/legion/extensions/prometheus/client.rb` | Standalone Client class |

## Authentication

Basic auth is optional. Pass `username:` and `password:` to the Client constructor if the Prometheus instance requires authentication.

## Dependencies

| Gem | Purpose |
|-----|---------|
| `faraday` (>= 2.0) | HTTP client for Prometheus HTTP API v1 |

## Development

12 specs total.

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
