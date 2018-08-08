require_relative "../plugin_helper"

describe Jobs::SidekiqMonitorPing do
  it "returns true" do
    expect(described_class.new.execute({})).to be true
  end
end
