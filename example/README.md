# Example for botground

## Install

```
$ bundle install
```

## Type Check

```
$ bundle exec steep check
```

## Run

set secret configs to .env

```
# .env
SLACK_OAUTH_TOKEN=...     # set Bot User OAuth Access Token in Slack Apps OAuth & Permissions
SLACK_SIGNING_SECRET=...  # set Signing Secret in Slack Apps Credentials
```

use two windows

```
$ bundle exec sidekiq -r ./worker.rb -P ./tmp/sidekiq.pid
```

```
$ bundle exec rackup config.ru
```
