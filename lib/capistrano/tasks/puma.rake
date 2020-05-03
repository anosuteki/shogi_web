# 実行タイミング
#
#   after 'deploy:starting',  'puma:quiet'
#   after 'deploy:updated',   'puma:stop'
#   after 'deploy:published', 'puma:start'
#   after 'deploy:failed',    'puma:restart'
#

# |----------------+--------------------------------------+----------------------|
# | コマンド       | 意味                                 | タイミング           |
# |----------------+--------------------------------------+----------------------|
# | kill -TSTP pid | 新規受付修正。スレッドを減らしていく | deploy:starting の前 |
# | kill -TERM pid | 完全停止                             | deploy:updated の後  |
# |                |                                      |                      |
# |----------------+--------------------------------------+----------------------|

# cap production puma:quiet

# set_if_empty :puma_pid_path, -> { Pathname(shared_path).join("tmp/pids/puma.pid") }

# append :rbenv_map_bins, 'puma', 'pumactl'

namespace :puma do
  desc "cap production puma:restart"
  after "deploy:restart", :restart do
    on roles(:app) do
      within current_path do
        execute :pwd
      end
    end
  end

  # desc "puma stop"
  # task :quiet do
  #   on roles(:app) do
  #     execute "kill -TSTP `cat #{fetch(:puma_pid_path)}`; true"
  #   end
  # end
  # before "deploy:updated", "puma:quiet"
  #
  # desc "puma kill"
  # task :kill do
  #   on roles(:app) do
  #     execute "kill -TERM `cat #{fetch(:puma_pid_path)}`; true"
  #   end
  # end
  # after "deploy:updated", "puma:kill"
end
