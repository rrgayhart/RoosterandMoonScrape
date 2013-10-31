source 'https://rubygems.org'

gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib', require: 'sinatra/reloader'
gem 'sequel'
gem 'pony'

group :test, :development do
  gem 'sqlite3'
  gem 'pry'
end

group :production do
  gem 'pg'
end
