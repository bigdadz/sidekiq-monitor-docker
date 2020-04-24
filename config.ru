require 'sidekiq'

# SIDEKIQ_URL example: redis://localhost:6379/0
Sidekiq.configure_client do |config|
  config.redis = config.redis = { url: ENV['REDIS_URL'] }
end

require 'sidekiq/web'
map '/' do
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
      Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  end

  run Sidekiq::Web
end