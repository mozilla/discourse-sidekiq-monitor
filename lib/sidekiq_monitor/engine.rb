module SidekiqMonitor
  class Engine < ::Rails::Engine
    engine_name 'sidekiq_monitor'
    isolate_namespace SidekiqMonitor
  end
end
