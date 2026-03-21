# lex-prometheus

LegionIO extension for querying Prometheus via the HTTP API v1.

## Installation

Add to your Gemfile:

```ruby
gem 'lex-prometheus'
```

## Standalone Usage

```ruby
require 'legion/extensions/prometheus'

client = Legion::Extensions::Prometheus::Client.new(
  url:      'http://prometheus:9090',
  username: 'admin',   # optional
  password: 'secret'   # optional
)

# Instant query
client.instant_query(query: 'up')
client.instant_query(query: 'up', time: '2026-01-01T00:00:00Z')

# Range query
client.range_query(query: 'rate(http_requests_total[5m])', start: '2026-01-01T00:00:00Z', end_time: '2026-01-02T00:00:00Z', step: '1h')

# Series
client.series(match: 'up')
client.series(match: '{job="prometheus"}', start: '2026-01-01T00:00:00Z')

# Labels
client.labels
client.label_values(label_name: 'job')

# Alerts and rules
client.list_alerts
client.list_rules
```

## Authentication

Basic auth is optional. Pass `username:` and `password:` to the Client constructor if your Prometheus instance requires authentication.

## License

MIT
