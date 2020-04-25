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

class Worker < BotGround::Worker
  def self.handlers
    [
      PongHandler,
    ]
  end
end

Worker.configure do |config|
  config.client = BotGround::Client.new(ENV["SLACK_OAUTH_TOKEN"].to_s)
end
