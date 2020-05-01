server 'ik1-413-38753.vs.sakura.ne.jp', user: 'deploy', roles: %w{app db web}

set :rbenv_ruby, '2.6.5'

set :keep_releases, 5

# 最初にアプリ削除する？
if ENV["APP_RESET"] == "1"
  before 'deploy:starting', 'deploy:app_clean'
end

# DBを作り直す？
if ENV["DB_RESET"] == "1"
  before 'deploy:migrate', 'deploy:db_reset'
end

set :rails_env, 'production'    # 必要

# append :linked_files, 'config/database.yml'

# 専用の database.yml を転送
before 'deploy:check:linked_files', 'deploy:database_yml_upload'

# さくらサーバーの容量がないため yarn のパッケージのキャッシュはクリアする (そもそもサーバー側でビルドしてない)
# after "deploy:finished", :yarn_cache_clean

# 起動確認
set :my_heartbeat_urls, ["https://shogi-flow.xyz/"]

# 起動するURL
set :open_urls, [
  "https://shogi-flow.xyz",
  "https://shogi-flow.xyz/w",
  "https://shogi-flow.xyz/w?query=kinakom0chi",
  "https://shogi-flow.xyz/adapter",
  "https://shogi-flow.xyz/xy",
  "https://shogi-flow.xyz/cpu/battles",
  "https://shogi-flow.xyz/stopwatch",
  "https://shogi-flow.xyz/x",
  "https://shogi-flow.xyz/x/new",
  "https://shogi-flow.xyz/board",
]

# if ENV["USE_NEW_DOMAIN"] && false
#   set :application, "shogi_web"
#
#   desc "storage を shogi_web_production/shared/storage にリンクする"
#   task :my_storeage_symlink do
#     on release_roles :all do
#       target = release_path.join("storage")
#       source = Pathname("/var/www/shogi_web_production/shared").join("storage")
#       if test "[ -d #{target} ]"
#         execute :rm, "-rf", target
#       end
#       execute :ln, "-s", source, target
#       execute :ls, "-al", "#{release_path}/"
#     end
#   end
#   before "deploy:symlink:linked_dirs", "my_storeage_symlink"
# else
#   append :linked_dirs, "storage"
# end

append :linked_dirs, "storage"

tp({
    application: fetch(:application),
    branch: fetch(:branch),
    deploy_to: fetch(:deploy_to),
    bundle_servers: fetch(:bundle_servers).collect(&:hostname).join(", "),
  })

# USE_NEW_DOMAIN=1 cap production server_setting
task :server_setting do
  on release_roles :all do
    tp "Passenger の作業ディレクトリ"
    execute :env, "| grep PASSENGER"
    execute :ls, "-al", "/var/run/passenger-instreg/*"

    tp "/var/run/* は再起動すると消されるためここで作る"
    execute :ls, "-al", "/etc/tmpfiles.d/passenger.conf"
    execute :cat, "/etc/tmpfiles.d/passenger.conf"

    tp "Apacheの設定は config/ishikari_passenger.conf をコピーしている"
    execute :ls, "-al", "/etc/httpd/conf.d/ishikari_passenger.conf"
    execute :cat, "/etc/httpd/conf.d/ishikari_passenger.conf"
  end
end
