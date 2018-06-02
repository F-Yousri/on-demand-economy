source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use sqlite3 as the database for Active Record
gem 'mysql2', '~> 0.5.1'
# Use Puma as the app server
gem 'puma', '~> 3.11', '>= 3.11.4'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'jwt'
gem 'carrierwave', '~> 1.0'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Use rails_admin for adminstaration panel
gem 'rails_admin', '~> 1.3'
gem 'devise'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
gem 'twilio-ruby'
gem 'activemerchant'
gem 'json', '~> 1.8', '>= 1.8.3'
gem 'faraday', '~> 0.15.2'
group :development, :test do
gem 'rspec-rails', '~> 3.5'
gem 'pry-rails'
end

gem 'pg'

group :test do
  gem "factory_girl_rails", "~> 4.0"
  gem 'shoulda-matchers', '~> 3.1'
  gem 'faker'
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby "2.5.1"