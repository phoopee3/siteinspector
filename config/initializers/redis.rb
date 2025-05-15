# frozen_string_literal: true

# Configure Redis connection for development (Docker)
if Rails.env.development?
  redis_host = ENV['REDIS_HOST'] || '172.18.0.2'
  # redis_host = ENV['REDIS_HOST'] || 'redis'
  redis_port = ENV['REDIS_PORT'] || 6379
  redis_url = "redis://#{redis_host}:#{redis_port}/0"
  
  # Set Redis URL for the application
  ENV['REDIS_URL'] = redis_url
  
  # Create a Redis connection pool that can be reused throughout the app
  REDIS_POOL = ConnectionPool.new(size: 5) do
    Redis.new(url: redis_url)
  end
else
  # For production, use REDIS_URL environment variable
  redis_url = ENV['REDIS_URL']
  REDIS_POOL = ConnectionPool.new(size: 5) do
    Redis.new(url: redis_url)
  end
end

# Configure Sidekiq
Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

