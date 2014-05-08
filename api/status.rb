module CallShibe
  ## 
  # Status API
  #
  # The status API checks the current status of the application
  # Unlike the PING API, the status API checks all integrations
  # If an integration passes, the value will be +true+
  # If an integration fails, the value will be +false+
  # If any value is +false+ then the application should be considered down/
  #
  class Status < Grape::API

    format :json
    
    ##
    # Check System Status
    #
    desc 'Get the system status, tests all integrations'
    get '/status' do
      status = {}
      
      # :have_life (always returns true)
      status[:have_life] = true


      # :have_db isn't really working yet...
      status[:have_db] = true

      # :have_twilio
      # Check that Twilio is working
      status[:have_twilio] = ::CallShibe.twilio.is_a?(Twilio::REST::Client)

      # Return status hash
      status
      
    end

  end
end
