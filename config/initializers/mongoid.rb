##
# Connect Konfrence to MongoDB
# (MongoDB is cool!)
##

require 'mongoid'
require 'logger'

Mongoid.load! File.join(ENV['KONFRENCE_ROOT'], 'config' , 'mongoid.yml')

if ENV['RACK_ENV'] == 'development'
  Mongoid.logger = Logger.new($stdout)
  Moped.logger   = Logger.new($stdout)

  Mongoid.logger.level = Logger::DEBUG
  Moped.logger.level   = Logger::DEBUG
end

# Load the models
Dir[ File.join(ENV['KONFRENCE_ROOT'] , 'app/models/*.rb') ].each do |model|
  puts model
  require model
end

