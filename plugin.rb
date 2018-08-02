# name: sidekiq-monitor
# about: Job that sends a ping from sidekiq to let us know it's still running
# version: 0.0.2
# authors: Leo McArdle
# url: https://github.com/mozilla/discourse-sidekiq-monitor

after_initialize do
  module ::Jobs
    class MozillaSidekiqMonitor < ::Jobs::Scheduled
      every 5.minutes
      sidekiq_options queue: 'critical'

      def execute(args)
        account_id = SiteSetting.newrelic_account_id
        key = SiteSetting.newrelic_insights_key

        return if account_id.blank? || key.blank?

        payload = [{
          eventType: :sidekiqRunning,
          value: 1
        }]

        uri = URI("https://insights-collector.newrelic.com/v1/accounts/#{account_id}/events")

        req = Net::HTTP::Post.new(uri, "Content-Type": "application/json")
        req["X-Insert-Key"] = "#{key}"
        req.body = payload.to_json

        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req)
        end

        unless res.code == "200"
          raise "Sidekiq monitor job failed with HTTP #{res.code}: #{res.body}"
        end
      end
    end
  end
end
