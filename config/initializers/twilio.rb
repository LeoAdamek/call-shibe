require 'twilio-ruby'

if ENV['TWILIO_SID'].nil? || ENV['TWILIO_TOKEN'].nil?
  credentials = YAML.load_file( File.join(ENV['SHIBE_ROOT'] , 'config/twilio.yml'))[ENV['RACK_ENV']]
  $twilio = Twilio::REST::Client.new(credentials['account'], credentials['token'])
else
  $twilio = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
end
