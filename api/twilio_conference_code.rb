require_relative 'helpers/conference_code_helper'

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

        call = ::Call.find_by(call_sid: params['CallSid'])

        if call
          call.add_action(
                          type: :digits,
                          digits: params['Digits']
                          )
          room = ::ConferenceRoom.find_room_for_call(join_code: params['Digits'],
                                                     inbound_number: params['To'])
          
          if room
            response = ::CallShibe::Helpers::ConferenceCodeHelper.get_join_response(room)
          else
            response = ::CallShibe::Helpers::ConferenceCodeHelper.get_reject_response
          end

          response

        else
          ::CallShibe::Helpers::ConferenceCodeHelper.get_reject_response
        end

      end
    end
  end
end
