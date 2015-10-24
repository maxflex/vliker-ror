set :output, "#{path}/log/cron.log"

# update tasks queue
every 15.minutes do
  command "echo 'Queue updated!'"
  runner "Task.cron_update_queue"
end
