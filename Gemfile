source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'
gem 'mysql2'
gem "acts_as_list"
gem "will_paginate"
gem "acts_as_indexed"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :production do
  # gems specifically for Heroku go here
  gem "pg"
end

group :development do
  gem 'rspec-rails', '2.6.1'
  gem 'annotate', '2.4.0'
end

group :test do
  # Pretty printed test output
  gem 'rspec-rails', '2.6.1'
  gem 'webrat', '0.7.1'
  gem 'turn', :require => false
  gem 'factory_girl_rails'
end
