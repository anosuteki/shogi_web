# -*- coding: utf-8; compile-command: "scp production.rb s:/var/www/shogi_web_production/current/config/puma; ssh s '(cd /var/www/shogi_web_production/current && bin/rails restart)' && ssh s 'sudo nginx -t && sudo /etc/rc.d/init.d/nginx restart'" -*-

pp({
    "whoami"    => `whoami`.strip,
    "Dir.pwd"   => Dir.pwd,
    "__FILE__"  => __FILE__,
    "RAILS_ENV" => ENV["RAILS_ENV"],
    "PORT"      => ENV["PORT"],
    "PIDFILE"   => ENV["PIDFILE"],
  })

# bind "unix://#{Rails.root}/tmp/sockets/puma.sock"
bind "unix:///var/www/shogi_web_production/shared/tmp/sockets/puma.sock"

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.

# port ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# workers (=プロセス数) はCPUコア数〜1.5倍を基本とする
# https://qiita.com/snaka/items/029889198def72e84209#puma-%E3%81%AE-worker-%E6%95%B0%E3%81%AE%E7%9B%AE%E5%AE%89

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
workers ENV.fetch("WEB_CONCURRENCY") { 1 }

# https://techracho.bpsinc.jp/hachi8833/2017_11_13/47696
# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

# tag "foobar"
# 
# # app do |env|
# #   puts env
# #   body = 'Hello, World!'
# #   [200, { 'Content-Type' => 'text/plain', 'Content-Length' => body.length.to_s }, [body]]
# # end
# 
# debug
