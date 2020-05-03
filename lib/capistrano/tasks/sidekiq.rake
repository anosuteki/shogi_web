# 実行タイミング
#
#   after 'deploy:starting',  'sidekiq:quiet'
#   after 'deploy:updated',   'sidekiq:stop'
#   after 'deploy:published', 'sidekiq:start'
#   after 'deploy:failed',    'sidekiq:restart'
#

# |----------------+--------------------------------------+----------------------|
# | コマンド       | 意味                                 | タイミング           |
# |----------------+--------------------------------------+----------------------|
# | kill -TSTP pid | 新規受付修正。スレッドを減らしていく | deploy:starting の前 |
# | kill -TERM pid | 完全停止                             | deploy:updated の後  |
# |                |                                      |                      |
# |----------------+--------------------------------------+----------------------|

# cap production sidekiq:quiet

set_if_empty :sidekiq_pid_path, -> { Pathname(shared_path).join("tmp/pids/sidekiq.pid") }

namespace :sidekiq do
  desc "sidekiq stop"
  task :quiet do
    on roles(:app) do
      execute "kill -TSTP `cat #{fetch(:sidekiq_pid_path)}`; true"
    end
  end
  before "deploy:updated", "sidekiq:quiet"

  desc "sidekiq kill"
  task :kill do
    on roles(:app) do
      execute "kill -TERM `cat #{fetch(:sidekiq_pid_path)}`; true"
    end
  end
  after "deploy:updated", "sidekiq:kill"
end
