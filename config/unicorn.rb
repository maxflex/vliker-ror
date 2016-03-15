listen "unix:/var/run/vliker.sock"
worker_processes 1
preload_app true
user "rails"
working_directory "/home/rails/vliker"
pid "/var/run/vliker.pid"
stderr_path "/var/log/unicorn/vliker.log"
stdout_path "/var/log/unicorn/vliker.log"
