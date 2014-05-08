require 'twilio-ruby'

module CallShibe

  def self.twilio
    @twilio
  end

  if ENV['TWILIO_SID'].nil? || ENV['TWILIO_TOKEN'].nil?
    credentials = YAML.load_file( File.join(self.root, 'config/twilio.yml'))[self.environment]
    @twilio = ::Twilio::REST::Client.new(credentials['account'], credentials['token'])
  else
    @twilio = ::Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
  end

end
