require_relative 'twilio_call_received'
require_relative 'twilio_call_status'
require_relative 'twilio_conference_code'

 module CallShibe
   class TwilioHooks < Grape::API

     # Twilio Speaks XML. (TwiML)
     format :xml

     resource :twilio do

       helpers do
         def validate_twilio_account!
           if params['AccountSid'] != $twilio.account_sid
             error! 'Invalid Account Sid', 403
           end
         end
       end

       mount ::CallShibe::TwilioCallbacks::CallReceived
       mount ::CallShibe::TwilioCallbacks::CallStatus
       mount ::CallShibe::TwilioCallbacks::ConferenceCode
       
       desc 'Twilio API Hook for an SMS being recieved'
       get 'sms-recieved' do
         
       end
       

     end
   end
 end
