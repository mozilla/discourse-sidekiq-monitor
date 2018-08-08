Dir["#{__dir__}/sidekiq_monitor/*.rb"].each do |file|
  require_relative file
end
