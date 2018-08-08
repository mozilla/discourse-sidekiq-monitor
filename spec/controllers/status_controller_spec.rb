require_relative "../plugin_helper"

describe SidekiqMonitor::StatusController do
  routes { SidekiqMonitor::Engine.routes }

  describe "#show" do

    context "when a job has run in the last minute" do
      before do
        Jobs.expects(:last_job_performed_at).returns(1.second.ago)
      end

      it "returns running: true" do
        get :show, format: :json
        expect(response.body).to eq({ running: true }.to_json)
      end
    end

    context "when no jobs have run in the last minute" do
      before do
        Jobs.expects(:last_job_performed_at).returns(1.minute.ago)
      end

      it "returns running: false" do
        get :show, format: :json
        expect(response.body).to eq({ running: false }.to_json)
      end
    end

    context "when no jobs have run ever" do
      before do
        Jobs.expects(:last_job_performed_at).returns(nil)
      end

      it "returns running: false" do
        get :show, format: :json
        expect(response.body).to eq({ running: false }.to_json)
      end
    end

  end
end
