module BotGround
  class Event
    def initialize(client, channel, user, text)
      @client = client
      @channel = channel
      @user = user
      @text = text
      @match_data = []
    end

    def channel
      @channel
    end

    def sender
      @user
    end

    def body
      @text
    end

    def set_match_data(match_data)
      @match_data = match_data
    end
  end
end
