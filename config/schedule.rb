set :output, "#{path}/log/cron.log"

# update tasks queue
every 1.minutes do
  command "echo 'Malec5'"
  runner "Task.cron_update_queue"
end
