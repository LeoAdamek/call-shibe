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

        if @call
          @call.add_action(
                           type: :digits,
                           digits: params['Digits']
                           )
                             
          
          @room = ::ConferenceRoom.find_room_for_call(join_code: params['Digits'],
                                                      inbound_number: params['To'])
          
          if @room
            response = get_join_response @room
          else
            response = get_reject_response
          end
          
          response

        else
          get_reject_response
        end
      end
      
      ##
      # Get TwiML response for joining `room`.
      #
      # @param [ConferenceRoom] room
      def get_join_response(room)
        logger.info "Call joined room: #{room.name}"

        response = TwiML::Response.new do |r|
          r.Say "Joining #{room.name} conference"
          r.Dial do |dial|
            dial.Conference room.join_options , room.name
          end
        end

        response
      end

      ##
      # Get TwiML response for rejecting a code
      #
      #
      def get_reject_response
        logger.info "Join code rejected"
        
        response = TwiML::Response.new do |r|
          r.Say "The conference code entered is invalid. Goodbye"
          r.Pause 1
          r.Hangup
        end

        response
      end

    end
  end
end
