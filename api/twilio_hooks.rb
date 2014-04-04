module Konfrence
  class TwilioHooks < Grape::API

    # Twilio Speaks XML. (TwiML)
    format :xml
    prefix '/twilio'

    desc 'Twilio API Hook for an incoming call being received'
    post 'call-received' do
      
    end

    desc 'Twilio API Hook for call status'
    post 'call-status' do
      
    end

    desc 'Twilio API Hook for an SMS being recieved'
    post 'sms-recieved' do
    end

    
  end
end
