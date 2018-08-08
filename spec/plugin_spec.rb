require_relative "plugin_helper"

describe Jobs::MozillaSidekiqMonitor do

  before do
    SiteSetting.newrelic_account_id = 1234
    SiteSetting.newrelic_insights_key = 5678
  end

  context "with newrelic account id and key set" do
    it "sends payload" do
      stub_request(:post, "https://insights-collector.newrelic.com/v1/accounts/1234/events").with({
        headers: {
          "Content-Type": "application/json",
          "X-Insert-Key": "5678"
        },
        body: '[{"eventType":"sidekiqRunning","value":1}]'
      }).to_return(status: 200)

      described_class.new.execute({})
    end
  end

  context "without newrelic account id set" do
    before { SiteSetting.newrelic_account_id = " " }

    it "does nothing" do
      described_class.new.execute({})
    end
  end

  context "without newrelic key set" do
    before { SiteSetting.newrelic_insights_key = " " }

    it "does nothing" do
      described_class.new.execute({})
    end
  end

  context "when querying the endpoint fails" do
    before do
      stub_request(:post, "https://insights-collector.newrelic.com/v1/accounts/1234/events").to_return(status: 500)
    end

    it "raises an error" do
      expect do
        described_class.new.execute({})
      end.to raise_error(RuntimeError)
    end
  end
end
