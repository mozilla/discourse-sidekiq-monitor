# sidekiq-monitor

*Exposes an endpoint to show the current status of sidekiq*

[![Build Status](https://travis-ci.org/mozilla/discourse-sidekiq-monitor.svg?branch=master)](https://travis-ci.org/mozilla/discourse-sidekiq-monitor)
 [![Coverage Status](https://coveralls.io/repos/github/mozilla/discourse-sidekiq-monitor/badge.svg?branch=master)](https://coveralls.io/github/mozilla/discourse-sidekiq-monitor?branch=master)

## Bug reports

Bug reports should be filed [by following the process described here](https://discourse.mozilla.org/t/where-do-i-file-bug-reports-about-discourse/32078).

## Usage

Set the API key in the `sidekiq_monitor_key` setting.

Then use that key in the X-Sidekiq-Monitor-Key header, to query `/sidekiq_monitor/status.json`:

```
curl -H 'X-Sidekiq-Monitor-Key: 1234' localhost:3000/sidekiq_monitor/status.json
```

If the key is invalid, the endpoint will return a 404 status.

If the key is valid, the endpoint will return a 200 status and:

- `running: true`, if sidekiq is running
- `running: false`, if sidekiq isn't running
