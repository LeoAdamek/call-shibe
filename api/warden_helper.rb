=begin
module CallShibe
  module WardenHelper

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
        request.env["access_token"].is_a?(String)
      end

      ##
      # Authenticate (if #valid? is true)
      def authenticate!
        User.authenticate(request.env["access_token"]) ? fail!("Authentication Error") : success!(true)
      end
    end

    helpers do
      ##
      # Authentication helper
      # Applied to all methods which require authentication
      def require_authentication!
        env['warden'].authenticate(:password)
        error! "Invalid access_token" , 401 unless env['warden'].user
      end
    end


  end
end
=end
