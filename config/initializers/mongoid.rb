##
# Connect CallShibe to MongoDB
# (MongoDB is cool!)
##

require 'mongoid'
require 'logger'

Mongoid.raise_not_found_error = false
Mongoid.load! File.join(ENV['SHIBE_ROOT'], 'config' , 'mongoid.yml')

if ENV['RACK_ENV'] == 'development'
  Mongoid.logger = Logger.new($stdout)
  Moped.logger   = Logger.new($stdout)

  Mongoid.logger.level = Logger::DEBUG
  Moped.logger.level   = Logger::DEBUG
end

# Load the models
Dir[ File.join(ENV['SHIBE_ROOT'] , 'app/models/*.rb') ].each do |model|
  puts model
  require model
end

