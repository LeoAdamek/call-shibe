module CallShibe
  ##
  # CallShibe Application
  #
  # Initializes the Rack application for CallShibe.
  # In here we can hook up stuff like a front-end UI too.
  class Application
   
    # This will be caled by Rack to initialize the application
    def self.instance

      @instance ||= Rack::Builder.new do

        run Application.new
      end.to_app

    end

    # This will be called by Rack on a new HTTP Request
    # Passes through to the API
    def call(env)
      # Call the API
      API.call(env)
    end

  end
end
