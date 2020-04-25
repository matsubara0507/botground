module BotGround
  class Handler
    # override
    def self.routers
      []
    end

    def self.find_router(text)
      self.routers.find { |router| router.match?(text) }
    end

    def self.route(pattern, action)
      Router.new(pattern, action)
    end
  end

  class Router
    def initialize(pattern, action)
      @pattern = pattern
      @action = action
    end

    def match?(text)
      !(@matched ||= @pattern.match(text)).nil?
    end

    def handle(event)
      event.set_match_data(@matched&.captures || [])
      @action.call(event)
    end
  end
end
