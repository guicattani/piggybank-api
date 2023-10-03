# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.4.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma'
# Use Active Model has_secure_password
gem 'bcrypt'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Presenters
gem 'fast_jsonapi'

group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_bot'
  gem 'pry-byebug'
  gem 'rubocop'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'guard-rspec', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'faker'
  gem 'rspec-rails', '~> 4.0.0.beta2'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

gem 'sidekiq'
gem 'clockwork'
gem 'devise'
gem 'devise-jwt', '~> 0.11.0'
