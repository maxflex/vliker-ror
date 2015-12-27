set :output, "#{path}/log/cron.log"

# update tasks queue
every 15.minutes do
  command "echo 'Queue updated!'"
  runner "Task.cron_update_queue"
end

#
# update order status
#
every 10.minutes do
  runnder 'Order.update_statuses(100)'
end
every 30.minutes do
  runnder 'Order.update_statuses(1000)'
end
every 1.hour do
  runnder 'Order.update_statuses(10000)'
end

# iNodes clean
every :weekend do
  command "rm -rf /home/rails/vliker/tmp/cache"
end
