# name: sidekiq-monitor
# about: Job that sends a ping from sidekiq to let us know it's still running
# version: 0.0.2
# authors: Leo McArdle
# url: https://github.com/mozilla/discourse-sidekiq-monitor

after_initialize do
  require_relative "plugin_code"
end
