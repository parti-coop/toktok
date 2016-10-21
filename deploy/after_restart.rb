on_app_servers do
  sudo "sleep 20s ; monit start all -g #{config.app}_sidekiq"
end
