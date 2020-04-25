require "sidekiq"
require "sinatra/base"
require "botground/client"
require "./worker.rb"

Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

Worker.configure do |config|
  config.client = BotGround::Client.new("TOKEN")
end

class API < Sinatra::Base
  post "/events", provides: :json do
    result = Worker.enqueue(request, verify: false)
    case result[:type]
    when "url_verification"
      content_type "text/plain"
      result[:value]
    when "event_callback"
      puts "success: #{result[:value]}"
      status 200
    else
      puts "undefined: #{result}"
      status 500
    end
  end
end

run Rack::Cascade.new([API])
