module Konfrence
  class TwilioHooks < Grape::API

    # Twilio Speaks XML. (TwiML)
    format :xml
    prefix '/twilio'

    desc 'Twilio API Hook for an incoming call being recieved'
    post 'call-recieved' do
      
    end

    desc 'Twilio API Hook for a call ending'
    post 'call-ended' do
      
    end

    desc 'Twilio API Hook for an SMS being recieved'
    post 'sms-recieved' do
    end

    
  end
end
