 module CallShibe
   class TwilioHooks < Grape::API

     # Twilio Speaks XML. (TwiML)
     format :xml

     resource :twilio do
 
     desc 'Twilio API Hook for an incoming call being received'
     post 'call-received' do
       begin
         @caller = ::CallShibe::Models::Caller.find_by( :phone_number => params["From"] )
       rescue
         @caller = nil
       end

       response = Twilio::TwiML::Response.new do |r|

         if @caller.nil?
           r.Say "Hello, welcome to Call Shibe. WOW! Such Conference."
         else
           r.Say "Hello #{@caller.name}."
         end

         r.pause 1

         if @caller.nil? || @caller.auto_join_room.nil?

           r.Gather(:numDigits => 4, :action => "/api/twilio/conference-code") do |code|
             code.Say "Please enter your four digit DOGE CODE to connect"
           end

         else
           r.Dial do |dailing|
             dailing.Conference @caller.auto_join_room
           end
         end

       end


       response
     end

     desc 'Twilio API Hook for call status'
     post 'call-status' do

     end

     desc "Twilio Call-back for checking a conference code"
     params do
       requires "Digits", type: String, desc: "Entered Conference code"
     end
     post 'conference-code' do
       {}
     end

     desc 'Twilio API Hook for an SMS being recieved'
     post 'sms-recieved' do
     end
       

     end
   end
 end
