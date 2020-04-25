require "slack-ruby-client"

module BotGround
  class Client
    def initialize(token)
      Slack.configure { |config| config.token = token }
      @slack_client = Slack::Web::Client.new
    end

    def postMessage(text, channel:)
      @slack_client.chat_postMessage(channel: channel, text: text)
    end
  end
end
