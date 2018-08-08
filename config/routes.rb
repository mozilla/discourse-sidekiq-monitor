Discourse::Application.routes.append do
  mount SidekiqMonitor::Engine => "/sidekiq_monitor"
end

module SidekiqMonitor
  Engine.routes.draw do
    get :status, to: "status#show", constraints: KeyConstraint.new
  end
end
