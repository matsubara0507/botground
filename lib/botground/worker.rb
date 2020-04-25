require "json"
require "sidekiq"
require "botground/event"
require "botground/client"

module BotGround
  class Worker
    include Sidekiq::Worker

    # override
    def self.handlers
      []
    end

    def self.configure
      yield self
    end

    def self.client
      @client
    end

    def self.client=(client)
      @client = client
    end

    def perform(channel, user, text)
      event = Event.new(self.class.client, channel, user, text, logger: logger)
      find_router(text)&.handle(event)
    end

    def self.enqueue(req, verify: true)
      request = Slack::Events::Request.new(req)
      return nil if verify && request.valid?

      payload = JSON.parse(request.body, symbolize_names: true)
      case payload[:type]
      when "event_callback"
        channel, user, text = get_event_info(payload[:event])
        return nil if channel.empty?
        {jid: perform_async(channel, user, text)}
      when "url_verification"
        return {challenge: payload[:challenge].to_s}
      else
        return nil
      end
    end

    private

    def find_router(text)
      self.class.handlers.each do |handler|
        router = handler.find_router(text)
        return router unless router.nil?
      end
      nil
    end

    def self.get_event_info(payload)
      case payload[:type].to_s
      when "message"
        [payload[:channel].to_s, payload[:user].to_s, payload[:text].to_s]
      else
        ["", "", ""]
      end
    end
  end
end
