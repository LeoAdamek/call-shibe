$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'api')
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'app')
$LOAD_PATH.unshift File.join(File.dirname(__FILE__))

$APP_ROOT ||= File.expand_path('../../', __FILE__)


# Load all the gems (:default and ENV)
require 'rubygems'
require 'bundler'
Bundler.require :default , ENV['RACK_ENV']

# Load the API
Dir[ File.join($APP_ROOT , 'api' , '*.rb')].each do |f|
  puts f
  require f
end

require File.expand_path('../../app/api', __FILE__)
require File.expand_path('../../app/app', __FILE__)

