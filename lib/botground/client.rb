require "slack-ruby-client"

module BotGround
  class Client
    def initialize(token)
      Slack.configure { |config| config.token = token }
      @slack_client = Slack::Web::Client.new
    end
  end
end