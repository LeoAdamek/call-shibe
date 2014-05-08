module CallShibe
  module TwilioCallbacks
    class ConferenceCode < Grape::API
      
      desc 'Twilio Call-back for checking a conference code'
      params do
        requires 'Digits', type: String, desc: 'Entered Conference code'
        requires 'AccountSid' , type: String, desc: 'Twilio Account Sid, must match configured account.'
        requires 'To' , type: String, desc: 'Number the call was made to'
      end
      get 'conference-code' do

        @call = ::Call.find_by(call_sid: params['CallSid'])

        if call
          @call.add_action(
                           type: :digits,
                           digits: params['Digits']
                           )
                             
          
          @room = ::ConferenceRoom.find_room_for_call(join_code: params['Digits'], inbound_number: params['To'])
          
          if @room
            response = Twilio::TwiML::Response.new do |r|
              r.Say "Thank you, you are now being connected to the #{@room.name} conference"
              r.Pause 1
              r.Dial do |dailing|
                dailing.Conference(@room.join_options, @room.name)
              end
            end
          else
            response = Twilio::TwiML::Response.new do |r|
              r.Say 'Sorry, but the code you have entered is invalid. Goodbye'
              r.Hangup
            end

          end

          
          response

        end
      end
    end
  end
end
