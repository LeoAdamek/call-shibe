module CallShibe
  class API < Grape::API
    prefix 'api'
    format :json

    attr_reader :logger
    @logger = Logger.new(::CallShibe.config['logging']['file'] || $STDOUT)

    use Warden::Manager do |manager|
      manager.scope_defaults :default,
                             strategies: [:access_token]

      manager.failure_app = self
    end

    ## If in development, add better_errors
    if ENV['RACK_ENV'] == 'development'
      use BetterErrors::Middleware
      BetterErrors.application_root = __dir__
    end

    # Access Token Strategy
    Warden::Strategies.add(:access_token) do
      ##
      # Check validity of access token
      def valid?
        env['HTTP_AUTHORIZATION'].is_a?(String)
      end

      ##
      # Authenticate (if #valid? is true)
      def authenticate!
        @user = ::APIUser.authenticate(request.env['HTTP_AUTHORIZATION'])

        @user ? true : false
      end
    end

    helpers do
      ##
      # Authentication helper
      # Applied to all methods which require authentication
      def require_authentication!
        return true if ::CallShibe.environment == 'development'

        env['warden'].authenticate(:access_token)
        error! 'Invalid access_token' , 401 unless env['warden'].user
      end

      attr_reader :logger
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
