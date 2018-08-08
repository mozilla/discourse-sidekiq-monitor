# name: sidekiq-monitor
# about: Exposes an endpoint to show the current status of sidekiq
# version: 0.1.0
# authors: Leo McArdle
# url: https://github.com/mozilla/discourse-sidekiq-monitor

enabled_site_setting :sidekiq_monitor_enabled

require_relative "lib/sidekiq_monitor"

after_initialize do
  if SiteSetting.sidekiq_monitor_enabled
    require_relative "jobs/scheduled/sidekiq_monitor_ping"
    Jobs.enqueue :sidekiq_monitor_ping
  end
end
