source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.5"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# Use sqlite3 as the database for Active Record
# gem "sqlite3"
gem 'mysql2', '>= 0.4.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "3.2.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
gem 'redis-namespace'
# gem 'redis', '3.3.3'
# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use ActiveStorage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling "console" anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# ################################################################################

group :development, :test do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring-commands-rspec"

  gem "capistrano", "3.11.0"
  gem "capistrano-rails"        # capistrano + capistrano-bundler
  gem "capistrano-rbenv"
  gem "capistrano-yarn"
  gem "capistrano-rails-console"
  gem "capistrano-maintenance", require: false
end

group :development do
  gem "foreman", require: false
end

gem "slim-rails"

gem "kaminari"

gem "memory_record"
gem "table_format"
gem "html_format"

group :development do
  gem "aam"
end

gem "rack-cors", require: "rack/cors" # 別のドメインからJSONアクセスできるようにするための何か

# エラー通知
gem "exception_notification"

# devise
gem "devise"
gem "devise-bootstrap-views"
gem "devise-i18n"
gem "devise-i18n-views"
gem "bcrypt"

# ActiveJob
gem 'sidekiq'
# gem 'sidekiq-failures'
# gem 'sidekiq-retries'
# gem 'sidekiq-status'
# gem 'sidekiq-monitor-stats', require: false
gem 'sinatra', require: false  # sidekiq web

