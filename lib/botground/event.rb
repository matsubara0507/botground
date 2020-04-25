module BotGround
  class Event
    def initialize(client, channel, user, text, logger: nil)
      @client = client
      @channel = channel
      @user = user
      @text = text
      @match_data = []
      @logger = logger
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

    def matched_data_at(idx)
      @match_data[idx]
    end

    def reply(message)
      @client.postMessage(message, channel: @channel)
    end

    def log(text, level: :info)
      return if @logger.nil?
      case level
      when :debug
        @logger&.debug(text)
      when :info
        @logger&.info(text)
      when :warn
        @logger&.warn(text)
      when :error
        @logger&.error(text)
      else
        return
      end
    end
  end
end
