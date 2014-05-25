module CallShibe
  ##
  # The "Ping" Module provides a sigle '/ping' method.
  # This method can be used to check that the app server is still alive.
  # It does not test integration.
  #
  class Ping < Grape::API
    format :json

    ##
    # Get a PING response, simply check that the app server is alive.
    # Does not test integration
    #
    # GET /ping
    # {"ping" : "pong"}
    #
    desc 'PING the API to check the app server is working'
    get '/ping' do
      { ping: :pong }
    end
  end
end
