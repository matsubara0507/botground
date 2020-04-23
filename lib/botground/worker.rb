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
      event = Event.new(Worker.client, channel, user, text)
      find_router(text)&.handle(event)
    end

    private

    def find_router(text)
      Worker.handlers.each do |handler|
        router = handler.find_router(text)
        return router unless router.nil?
      end
      nil
    end
  end
end
