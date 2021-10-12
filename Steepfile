target :lib do
  signature "sig", "assets/sig"

  check "lib"                       # Directory name

  library "logger" # for sidekiq
  library "monitor" # for logger

  repo_path "vendor/rbs/gem_rbs_collection/gems"
  library "rack", "sidekiq"
  library "redis" # for sidekiq
end

# target :spec do
#   signature "sig", "sig-private"
#
#   check "spec"
#
#   # library "pathname", "set"       # Standard libraries
#   # library "rspec"
# end
