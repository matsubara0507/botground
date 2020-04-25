require "sidekiq"
require "botground"
require "dotenv/load"

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
end

class PongHandler < BotGround::Handler
  def self.routers
    [
      route(/^ping$/, ->(event) do
        event.log("pong")
        event.reply("pong")
      end),
    ]
  end
end

class EchoHandler < BotGround::Handler
  def self.routers
    [
      route( /^echo\s+(.+)/, ->(event) do
        event.log("echo")
        text = event.matched_data_at(0)
        event.reply(text.to_s) unless text.nil?
      end),
    ]
  end
end

class Worker < BotGround::Worker
  def self.handlers
    [
      PongHandler,
      EchoHandler,
    ]
  end
end

Worker.configure do |config|
  config.client = BotGround::Client.new(ENV["SLACK_OAUTH_TOKEN"].to_s)
  config.signing_secret = ENV["SLACK_SIGNING_SECRET"].to_s
end
