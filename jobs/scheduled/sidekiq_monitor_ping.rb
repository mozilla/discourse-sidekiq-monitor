module ::Jobs
  class SidekiqMonitorPing < ::Jobs::Scheduled
    every 30.seconds
    sidekiq_options queue: "critical"

    def execute(args)
      true
    end
  end
end
