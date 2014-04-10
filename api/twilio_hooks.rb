 module CallShibe
   class TwilioHooks < Grape::API

     # Twilio Speaks XML. (TwiML)
     format :xml

     resource :twilio do

       helpers do
         def validate_twilio_account!
           if params["AccountSid"] != $twilio.account_sid
             error! "Invalid Account Sid", 403
           end
         end
       end
       
       desc 'Twilio API Hook for an incoming call being received'
       params do
         requires "From" , type: String, desc: "Caller's phone number"
         requires "CallSid" , type:String , desc: "Twilio Call Sid"
         requires "AccountSid" , type:String, desc: "Twilio Account Sid, Must match the configured account."
       end
       get 'call-received' do

         validate_twilio_account!

         @caller = ::Caller.find_by( :phone_number => params["From"])
         
         @call = ::Call.create!(
                                :caller => @caller,
                                :call_started_at => Time.now,
                                :call_sid => params["CallSid"],
                                :call_status => "New"
                                )

         unless @caller.nil?
           if @caller.auto_join_room
             @call.room_name = @caller.auto_join_room
             @call.save!
           end
         end
         
         response = Twilio::TwiML::Response.new do |r|
           
           if @caller.nil?
             r.Say "Hello, welcome to Call Shibe. WOW! Such Conference."
             @call[:from_number] = params["From"]
             @call.save!
           else
             r.Say "Hello #{@caller.name}."
           end
           
           r.Pause 1
           
           if @caller.nil? || @caller.auto_join_room.nil?
             
             r.Gather(:numDigits => 4, :action => "/api/twilio/conference-code", :method => "GET") do |code|
               code.Say "Please enter your four digit DOGE CODE. Then press the Hash key."
             end
             
           else
             r.Say "You are being connected to the #{@caller.auto_join_room} conference"
             r.Pause 1
             r.Dial do |dailing|
               dailing.Conference @caller.auto_join_room
             end
           end
           
         end

         response
       end
       
       desc 'Twilio API Hook for call status'
       params do
         requires "CallSid" , type: String , desc: "Twilio Call SID"
         requires "CallDuration", type: Integer , desc: "Length of the completed call"
         requires "CallStatus" , type: String, desc: "Call Status"
         requires "AccountSid" , type: String, desc: "Twilio Account Sid, must match configured account."
       end
       get 'call-status' do

         validate_twilio_account!
         
           @call = ::Call.find_by(:call_sid => params["CallSid"])

           @call.duration_seconds = params["CallDuration"]
           @call.call_status = params["CallStatus"]

           @call.save!

           {:acknowledged => true}
       end

       desc "Twilio Call-back for checking a conference code"
       params do
         requires "Digits", type: String, desc: "Entered Conference code"
         requires "AccountSid" , type: String, desc: "Twilio Account Sid, must match configured account."
       end
       get 'conference-code' do
         @room = ::ConferenceRoom.find_by(:join_code => params["Digits"])

         if @room
           response = Twilio::TwiML::Response.new do |r|
             r.Say "Thank you, you are now being connected to the #{@room.name} conference"
             r.Pause 1
             r.Dial do |dailing|
               dailing.Conference( {
                                     beep: @room.options.beep,
                                     record: @room.options.record,
                                     maxParticipants: @room.options.max_participants,
                                     trim: @room.options.trim_silence ? 'trim-silence' : 'do-not-trim',
                                     waitURL: @room.options.wait_audio
                                   } , @room.name )

             end
           end
         else
           response = Twilio::TwiML::Response.new do |r|
             r.Say "Sorry, but the code you have entered is invalid. Goodbye"
             r.Hangup
           end
         end

           
         response

       end

       desc 'Twilio API Hook for an SMS being recieved'
       post 'sms-recieved' do
       end
       

     end
   end
 end
