module CallShibe
  class API < Grape::API

    prefix 'api'
    format :json

    
    use Warden::Manager do |manager|
      manager.scope_defaults :default,
      strategies: [:access_token]
      
      manager.failure_app = self
    end


    # Access Token Strategy
    Warden::Strategies.add(:access_token) do
      ## 
      # Check validity of access token
      def valid?
        puts request.env["access_token"] || "Nothing :("
        request.env["access_token"].is_a?(String)
      end

      ##
      # Authenticate (if #valid? is true)
      def authenticate!
        puts request.env.to_json
        User.authenticate(request.env["access_token"]) ? fail!("Authentication Error") : success!(true)
      end
    end

    helpers do
      ##
      # Authentication helper
      # Applied to all methods which require authentication
      def require_authentication!
        env['warden'].authenticate(:access_token)
        error! "Invalid access_token" , 401 unless env['warden'].user
      end
    end


    mount ::CallShibe::Callers
    mount ::CallShibe::Calls
    mount ::CallShibe::ConferenceRooms

    mount ::CallShibe::Status
    mount ::CallShibe::Ping

    mount ::CallShibe::TwilioHooks


    # Add documentation via Swagger
    add_swagger_documentation mount_path: 'doc' , markdown: true , api_version: 'v1' , hide_documentation_path: true
    
  end
end
