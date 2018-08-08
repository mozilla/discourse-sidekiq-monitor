module SidekiqMonitor
  class StatusController < ApplicationController
    def show
      last_run = Jobs.last_job_performed_at
      stopped = last_run.nil? || last_run < 1.minute.ago
      render json: { running: !stopped }
    end
  end
end
