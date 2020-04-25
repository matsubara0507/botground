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
  post "/events", provides: :json do
    case Worker.enqueue(request, verify: false)
    in {challenge: code}
      content_type "text/plain"
      code
    in {jid: jid}
      puts "success: #{jid}"
      status 200
    in err
      puts "undefined: #{err}"
      status 500
    end
  end
end

run Rack::Cascade.new([API])
