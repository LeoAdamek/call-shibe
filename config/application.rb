require 'yaml'

module CallShibe

  $LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'api')
  $LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'app')
  $LOAD_PATH.unshift File.join(File.dirname(__FILE__))

  def self.root
    File.expand_path('../../', __FILE__)
  end

  def self.environment
    ENV['RACK_ENV'] || 'development'
  end

  def self.config_file
    ENV['SHIBE_CONFIG_FILE'] || File.join(self.root , 'config/call_shibe.yml')
  end

  def self.config
    ::YAML.load_file(self.config_file)[self.environment]
  end

  # Load all the gems (:default and ENV)
  require 'rubygems'
  require 'bundler'
  Bundler.require :default , ENV['RACK_ENV']

  # Load the initializers
  Dir[ File.expand_path('../initializers/*.rb', __FILE__) ].each do |initializer|
    require initializer
  end


  # Load the API
  Dir[ File.join(self.root , 'api' , '*.rb')].each do |f|
    require f
  end

  require File.expand_path('../../app/api', __FILE__)
  require File.expand_path('../../app/app', __FILE__)

end
