module CallShibe
  module Helpers
    class ConferenceCodeHelper


      ##
      # Get TwiML response for joining `room`.
      #
      # @param [ConferenceRoom] room
      def self.get_join_response(room)
        response = Twilio::TwiML::Response.new do |r|
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
      def self.get_reject_response
        response = Twilio::TwiML::Response.new do |r|
          r.Say 'The conference code entered is invalid. Goodbye'
          r.Pause 1
          r.Hangup
        end

        response
      end


    end
  end
end
