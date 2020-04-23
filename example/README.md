```
$ bundle exec sidekiq -r ./worker.rb -P ./tmp/sidekiq.pid
$ bundle exec rackup config.ru
```