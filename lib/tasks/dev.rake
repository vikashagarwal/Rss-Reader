namespace :dev do
  desc 'Clear redis queue'
  task clear_redis: :environment do
    Sidekiq::RetrySet.new.clear
    Sidekiq::ScheduledSet.new.clear
    Sidekiq::Queue.all.clear
    `redis-cli flushall`
  end

  desc 'Restart Sidekiq'
  task restart_sidekiq: :environment do
    `bundle exec sidekiqctl stop tmp/pids/sidekiq.pid`
    `crontab -r`
    `whenever -i --set environment=#{Rails.env}`
    `bundle exec sidekiq -d -L log/sidekiq.log -e #{Rails.env} -p tmp/pids/sidekiq.pid`
  end
end
