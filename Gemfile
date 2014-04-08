##
## Gemfile for Konfsense
##

source 'https://rubygems.org/'


gem 'rack'
gem 'warden'

gem 'grape'
gem 'grape-swagger'

gem 'mongoid' , '~>3.1.6'
gem 'twilio-ruby' , github: 'LeoAdamek/twilio-ruby'

# For Rake Tasks
gem 'terminal-table'

group :development do
  gem 'guard'

  gem 'guard-rack'
  gem 'guard-bundler'

  gem 'rubocop'

  gem 'pry'
  gem 'rake'
end


group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'capybara'
end

group :production do
  gem 'thin'
end
