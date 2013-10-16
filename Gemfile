source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc2'

# Use sqlite3 for development
gem 'sqlite3'

# Use postgresql for production
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

group :assets do
  gem 'therubyracer', platforms: :ruby
end

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Use Haml for view templates
gem 'haml-rails'

# Twitter Boostrap, no less support
gem "twitter-bootstrap-rails"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'omniauth-github'
gem 'faraday'

gem 'resque', :require => "resque/server"
gem 'resque-scheduler', :require => 'resque_scheduler'

gem 'activeadmin', github: 'gregbell/active_admin'

gem 'foreman'
gem 'unicorn'

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'vcr'
end
