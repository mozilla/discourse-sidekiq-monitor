module SidekiqMonitor
  class KeyConstraint

    def matches?(req)
      if req.headers['X-Sidekiq-Monitor-Key'] == SiteSetting.sidekiq_monitor_key
        true
      elsif AdminConstraint.new.matches? req
        true
      else
        false
      end
    end

  end
end
