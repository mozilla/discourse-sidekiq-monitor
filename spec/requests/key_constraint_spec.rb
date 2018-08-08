require_relative "../plugin_helper"

describe SidekiqMonitor::KeyConstraint do
  before do
    SiteSetting.sidekiq_monitor_key = "1234"
  end

  let(:admin) { Fabricate(:admin) }
  let(:user) { Fabricate(:user) }

  context "no key is sent" do
    it "returns 404" do
      get "/sidekiq_monitor/status.json"
      expect(response).to have_http_status(404)
    end
  end

  context "invalid key is sent" do
    let(:headers) { { "X-Sidekiq-Monitor-Key": "5678" } }

    it "returns 404" do
      get "/sidekiq_monitor/status.json", headers: headers
      expect(response).to have_http_status(404)
    end
  end

  context "correct key is sent" do
    let(:headers) { { "X-Sidekiq-Monitor-Key": "1234" } }

    it "returns 200" do
      get "/sidekiq_monitor/status.json", headers: headers
      expect(response).to have_http_status(200)
    end
  end

  context "user logged in" do
    before do
      sign_in(user)
    end

    it "returns 404" do
      get "/sidekiq_monitor/status.json"
      expect(response).to have_http_status(404)
    end
  end

  context "admin logged in" do
    before do
      sign_in(admin)
    end

    it "returns 200" do
      get "/sidekiq_monitor/status.json"
      expect(response).to have_http_status(200)
    end
  end
end
