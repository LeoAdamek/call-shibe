module CallShibe
  module TwilioCallbacks
    class CallReceived < Grape::API
      desc 'Twilio API Hook for an incoming call being received'
      params do
        requires 'From',
                 type: String,
                 desc: 'Caller\'s phone number'

        requires 'CallSid',
                 type: String,
                 desc: 'Twilio Call Sid'

        requires 'AccountSid',
                 type: String,
                 desc: 'Twilio Account Sid, Must match the configured account.'
      end
      get 'call-received' do

        validate_twilio_account!

        @caller = ::Caller.find_by(phone_number: params['From'])

        @call = ::Call.create!(
                               caller: @caller,
                               call_started_at: Time.now,
                               call_sid: params['CallSid'],
                               call_status: params['CallStatus']
                               )

        unless @caller.nil?
          if @caller.auto_join_room
            @call.room_name = @caller.auto_join_room
            @call.save!
          end
        end

        response = Twilio::TwiML::Response.new do |r|

          if @caller.nil?
            r.Say ::CallShibe::Configuration.welcome_message
            @call[:from_number] = params['From']
            @call.save!
          else
            r.Say "Hello #{@caller.name}."
          end

          r.Pause 1

          if @caller.nil? || @caller.auto_join_room.nil?

            r.Gather(
                     numDigits: 4,
                     action: '/api/twilio/conference-code',
                     method: 'GET') do |code|

              code.Say(
                       'Please enter your four digit DOGE CODE. Then press the Hash key.'
                       )

            end

          else
            r.Say (
                   "You are being connected to the #{@caller.auto_join_room} conference"
                   )
            r.Pause 1
            r.Dial do |dailing|
              dailing.Conference @caller.auto_join_room
            end
          end
        end
        response
      end
    end
  end
end
