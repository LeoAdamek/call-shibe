module CallShibe
  class API < Grape::API

    prefix 'api'
    format :json

    mount ::CallShibe::Callers

    mount ::CallShibe::Status
    mount ::CallShibe::Ping

    mount ::CallShibe::TwilioHooks

    

  end
end
