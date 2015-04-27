module CallShibe
  module Helpers
    ##
    # Helper methods for conference rooms
    # 
    # Generates templated TwiML responses to actions
    class ConferenceCodeHelper
      ##
      # Get TwiML response for joining `room`.
      #
      # @param [ConferenceRoom] room
      def self.get_join_response(room)
        response = Twilio::TwiML::Response.new do |r|
          r.Say "Joining #{room.name} conference"
          r.Dial do |dial|
            dial.Conference self.transform_join_options(room.join_options) , room.name
          end
        end

        response
      end

      ##
      # Get TwiML response for rejecting a code
      #
      def self.get_reject_response
        response = Twilio::TwiML::Response.new do |r|
          r.Say 'The conference code entered is invalid. Goodbye'
          r.Pause 1
          r.Hangup
        end

        response
      end

      ##
      # Transform Options for Response
      #
      # Transform the options hash from what we use
      # in the app, to Twilio's Vendor specific layout
      private
      def self.transform_join_options(options)
        {
          beep: options[:beep].to_s,
          muted: options[:muted].to_s,
          waitUrl: '/api/twilio/wait-audio',
          waitMethod: 'GET',
          record: options[:record] ? 'record-from-start' : 'do-not-record',
          tim: options[:trim] ? 'trim-silence' : 'do-not-trim'
        }
      end
    end
  end
end
