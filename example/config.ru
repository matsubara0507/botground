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
  post "/events" do
    jid = Worker.perform_async("hoge", "fuga", "ping")
    puts "success: #{jid}"
    status 200
  end
end

run Rack::Cascade.new([API])
