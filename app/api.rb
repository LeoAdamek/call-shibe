module CallShibe
  class API < Grape::API

    prefix 'api'
    format :json

    mount ::CallShibe::Callers
    mount ::CallShibe::Calls
    mount ::CallShibe::ConferenceRooms

    mount ::CallShibe::Status
    mount ::CallShibe::Ping

    mount ::CallShibe::TwilioHooks

    
    add_swagger_documentation
  end
end
