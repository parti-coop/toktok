if Rails.env.development? or Rails.env.test?
  require 'sidekiq/testing'
  Sidekiq::Testing.inline!
else
  Sidekiq.configure_server do |config|
    config.redis = {namespace: "hotlinekr:#{Rails.env}"}
  end
  Sidekiq.configure_client do |config|
    config.redis = {namespace: "hotlinekr:#{Rails.env}"}
  end
end
