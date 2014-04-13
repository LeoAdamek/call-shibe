module CallShibe
  module TwilioCallbacks
    class CallStatus < Grape::API

      desc 'Twilio API Hook for call status'
      params do
        requires 'CallSid' , type: String , desc: 'Twilio Call SID'
        requires 'CallDuration', type: Integer , desc: 'Length of the completed call'
        requires 'CallStatus' , type: String, desc: 'Call Status'
        requires 'AccountSid' , type: String, desc: 'Twilio Account Sid, must match configured account.'
      end
      get 'call-status' do

        validate_twilio_account!
        
        @call = ::Call.find_by(call_sid: ['CallSid'])

        @call.duration_seconds = params['CallDuration']
        @call.call_status = params['CallStatus']

        @call.save!

        {acknowledged: true}
      end

    end
  end
end
