source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
#Use Bootstrap
gem 'bootstrap-sass', '~> 3.3.6'
#Support for bootswatch themes
gem 'bootswatch-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'jquery-rails'
gem 'simple_form'
gem 'figaro'
gem 'money-rails'
gem 'ransack'
gem 'stripe'
gem 'rails_admin', '~> 1.2'
gem 'paper_trail'

gem 'modernizr-rails'
gem 'auto_strip_attributes'
gem 'aws-sdk'
gem 'paperclip'
gem 'slack-notifier'
gem 'exception_notification'
gem 'devise'
gem 'omniauth-oauth2', '1.3.1'
gem 'omniauth-linkedin-oauth2'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test, :staging do
  gem 'faker'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'bullet'
end

group :test do
  gem 'shoulda-matchers'
  gem 'chromedriver-helper'
  gem 'simplecov'
  gem 'rack_session_access'
  gem 'stripe-ruby-mock', :path => File.join(File.dirname(__FILE__), 'vendor', 'gems', 'stripe-ruby-mock')
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
