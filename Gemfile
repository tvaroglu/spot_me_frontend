source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.6.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'execjs'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.15', require: false

gem 'faraday', '~> 1.10'
gem 'omniauth', '~> 2.0'
gem 'omniauth-google-oauth2', '~> 0.8.1'
gem 'omniauth-rails_csrf_protection', '~> 1.0'

group :development, :test do
  gem 'pry'
  gem 'figaro'
end

group :development do
  gem 'web-console', '~> 4.2'
  gem 'listen', '>= 3.6', '< 4.0'
  gem 'rubocop', '~> 1.42', require: false
  gem 'rubocop-performance', '~> 1.15', require: false
  gem 'rubocop-rails', '~> 2.16', require: false
  gem 'rubocop-rake', '~> 0.6', require: false
  gem 'rubocop-rspec', '~> 2.5', require: false
end

group :test do
  gem 'rspec-rails', '~> 5.1'
  gem 'factory_bot_rails', '~> 6.3'
  gem 'faker', '~> 2.23'
  gem 'webmock', '~> 3.23'
  gem 'vcr', '~> 6.0'
  gem 'capybara', '~> 3.40'
  gem 'simplecov', '~> 0.22'
  gem 'shoulda-matchers', '~> 5.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
