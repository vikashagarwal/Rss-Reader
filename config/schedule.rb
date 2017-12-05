# job_type :sidekiq, "cd :path && :environment_variable=:environment bundle exec whenever --update-crontab #{fetch(:application)}"

every 15.minutes, :roles => [:app] do
  runner "FeedWorker.perform_async"
end