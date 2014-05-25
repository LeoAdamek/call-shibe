# Rack Configuration File
# Bootstraps Application for Rack

require File.expand_path('../config/environment' , __FILE__)

# Run the application
run CallShibe::Application.instance
