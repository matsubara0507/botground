lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "botground/version"

Gem::Specification.new do |spec|
  spec.name          = "botground"
  spec.version       = BotGround::VERSION
  spec.authors       = ["MATSUBARA Nobutada"]
  spec.summary       = "Framework for Slack Bot based on Events API by Ruby"

  spec.metadata["source_code_uri"] = "https://github.com/matsubara0507/botground"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.0.0"

  spec.add_dependency "sinatra", ">= 2.0"
  spec.add_dependency "sidekiq", ">= 6.0"
  spec.add_dependency "slack-ruby-client", ">= 0.14"
  spec.add_development_dependency "bundler", "< 3"
end
