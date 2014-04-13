module CallShibe
  module TwilioCallbacks
    class ConferenceCode < Grape::API
      
      desc 'Twilio Call-back for checking a conference code'
      params do
        requires 'Digits', type: String, desc: 'Entered Conference code'
        requires 'AccountSid' , type: String, desc: 'Twilio Account Sid, must match configured account.'
      end
      get 'conference-code' do

        @call = ::Call.find_by(call_sid: params['CallSid'])

        if call
          @call[:actions] ||= []
          @call[:actions] << {
            type: :entered_digits,
            digits: params['Digits']
          }

          @call.save
        end

        @room = ::ConferenceRoom.find_by(join_code: params['Digits'])

        if @room
          response = Twilio::TwiML::Response.new do |r|
            r.Say "Thank you, you are now being connected to the #{@room.name} conference"
            r.Pause 1
            r.Dial do |dailing|
              dailing.Conference( {
                                    beep: @room.room_options.beep,
                                    record: @room.room_options.record,
                                    maxParticipents: @room.room_options.max_participents,
                                    trim: @room.room_options.trim_silence ? 'trim-silence' : 'do-not-trim',
                                    waitURL: @room.room_options.wait_audio
                                  } , @room.name )

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
