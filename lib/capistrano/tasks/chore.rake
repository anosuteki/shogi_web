desc "credentials"
task :credentials do
  credentials = YAML.load(`rails credentials:show`)
  pp credentials
end

desc "cap production crontab"
task :crontab do
  on roles(:all) do
    execute "crontab -l"
  end
end

desc "cap production yarn_cache_clean"
task :yarn_cache_clean do
  on roles(:all) do
    # execute "ls -al ~/.cache/yarn/v1"
    execute "yarn cache clean"
    # execute "ls -al ~/.cache/yarn/v1"
  end
end

namespace :deploy do
  # desc 'Restart application'
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     execute :touch, release_path.join('tmp/restart.txt')
  #   end
  # end
  #
  # after :publishing, :restart

  # -  after "deploy:assets:precompile", :chmod_R do
  # -    on roles(:web), in: :groups, limit: 3, wait: 10 do
  # -      execute :chmod, "-R ug+w #{fetch(:deploy_to)}"
  # -    end
  # -  end

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end
  #

  if true
    task :app_clean do
      on roles(:all) do
        execute :rm, '-rf', deploy_to
        # execute :rake, "db:create"
      end
    end
    # before 'deploy:starting', 'deploy:app_clean'

    desc 'db_seed must be run only one time right after the first deploy'
    task :db_seed do
      on roles(:db) do |host|
        within release_path do
          # execute :pwd
          # execute :ls, "-al app/models"

          with rails_env: fetch(:rails_env) do
            execute :rake, 'db:seed'
          end
        end
      end
    end
    after 'deploy:migrate', 'deploy:db_seed'

    # desc 'Runs rake db:migrate if migrations are set'
    task db_reset: [:set_rails_env] do
      on primary fetch(:migration_role) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :rake, "db:drop", "DISABLE_DATABASE_ENVIRONMENT_CHECK=1"
            execute :rake, "db:create"
          end
        end
      end
    end
    # before 'deploy:migrate', 'deploy:db_reset'
  end

  # set :app_version, '1.2.3'
  # after :finished, 'airbrake:deploy'
end

desc "間違わないようにバナー表示"
before "deploy:starting", :starting_banner do
  label = "#{fetch(:application)} #{fetch(:branch)} to #{fetch(:stage)}".gsub(/[_\W]+/, " ")
  puts Artii::Base.new(font: "slant").output(label)
  system "say '#{label}'"
end

desc "サーバー起動確認"
after "deploy:finished", :hb do
  Array(fetch(:my_heartbeat_urls)).each do |url|
    puts `curl --silent -I #{url} | grep HTTP`.strip
  end
end

desc "デプロイ失敗"
task "deploy:failed" do
  system "say 'デプロイに失敗しました'"
end

desc "デプロイ成功"
after "deploy:finished", :finished_banner do # finished にすると動かない
  label = "#{fetch(:branch)} to #{fetch(:stage)} deploy finished".gsub(/[_\W]+/, " ")
  puts Artii::Base.new(font: "slant").output(label)
  system "say '#{label}'"
end
