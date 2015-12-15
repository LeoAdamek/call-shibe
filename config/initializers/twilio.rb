require 'twilio-ruby'

module CallShibe
  def self.twilio
    @twilio
  end

  if ENV['TWILIO_SID'].nil? || ENV['TWILIO_TOKEN'].nil?
    #credentials = YAML.load_file(File.join(root, 'config/twilio.yml'))[environment]
    #@twilio = ::Twilio::REST::Client.new(credentials['account'], credentials['token'])
  else
    #@twilio = ::Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
  end
end
