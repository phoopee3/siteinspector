# frozen_string_literal: true

require 'sidekiq/fetch'
require 'sidekiq/dynamic_fetch'
require 'sidekiq/dynamic_push'
require 'sidekiq/dynamic_queues'
require 'sidekiq/dynamic_queues_web'

# Configure Redis connection for Sidekiq if not already configured
unless defined?(REDIS_POOL)
  redis_host = ENV['REDIS_HOST'] || '172.18.0.3'
  redis_port = ENV['REDIS_PORT'] || 6379
  redis_url = "redis://#{redis_host}:#{redis_port}/0"
  
  # Set Redis URL for the application
  ENV['REDIS_URL'] = redis_url
  
  # Configure Sidekiq with Redis URL
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end
end

Sidekiq::DynamicQueues.setup! if Sidekiq::DynamicQueues.enabled?

Sidekiq::Web.register(Sidekiq::DynamicQueuesWeb)
