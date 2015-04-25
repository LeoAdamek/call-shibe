##
# Connect CallShibe to MongoDB
# (MongoDB is cool!)
##

require 'mongoid'
require 'logger'

module CallShibe
  Mongoid.raise_not_found_error = false
  Mongoid.load! File.join(root, 'config' , 'mongoid.yml')

  # Set up Mongoid/Moped logging
  Mongoid.logger = Logger.new(::CallShibe::Configuration.logging,file || STDOUT)
  Moped.logger   = Logger.new(::CallShibe::Configuration.logging.file || STDOUT)

  if environment == 'development'
    Mongoid.logger.level = Logger::DEBUG
    Moped.logger.level   = Logger::DEBUG
  else
    Mongoid.logger.level = Logger::INFO
    Moped.logger.level   = Logger::INFO
  end

  # Load the models
  Dir[ File.join(root , 'app/models/*.rb')].each do |model|
    require model
  end
end
