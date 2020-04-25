require "sidekiq"
require "sinatra/base"
require "botground/client"
require "dotenv/load"
require "./worker.rb"

Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

Worker.configure_client do |config|
  config.signing_secret = ENV["SLACK_SIGNING_SECRET"].to_s
end

class API < Sinatra::Base
  post "/events", provides: :json do
    result = Worker.enqueue(BotGround::HTTPRequest.new(headers: request.env, body: request.body))
    case result[:type]
    when "url_verification"
      content_type "text/plain"
      result[:value]
    when "event_callback"
      puts "success: #{result[:value]}"
      status 200
    else
      puts "undefined: #{result}"
      status 200
    end
  end
end

run Rack::Cascade.new([API])
