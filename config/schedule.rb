set :output, "#{path}/log/cron.log"
# set :environment, ENV['RAILS_ENV']
# env :APP_DATABASE_PASSWORD, ENV['APP_DATABASE_PASSWORD']
# env :PATH, ENV['PATH']

every 1.minutes do
    command "echo '100 orders updated!'"
    runner 'Order.update_statuses(100)'
end

# # update tasks queue
# every 15.minutes do
#   command "echo 'Queue updated!'"
#   runner "Task.cron_update_queue"
# end
#
# #
# # update order status
# #
# every 10.minutes do
#   command "echo '100 orders updated!'"
#   command "echo 'PASSWORD: #{ENV['APP_DATABASE_PASSWORD']}'"
#   runner 'Order.update_statuses(100)'
# end
# every 30.minutes do
#   command "echo '1000 orders updated!'"
#   runner 'Order.update_statuses(1000)'
# end
# every 1.hour do
#   command "echo '10000 orders updated!'"
#   runner 'Order.update_statuses(10000)'
# end
#
# #
# # iNodes clean
# #
# every :weekend do
#   command "echo 'iNodes cleaned!'"
#   command "rm -rf /home/rails/vliker/tmp/cache"
# end
