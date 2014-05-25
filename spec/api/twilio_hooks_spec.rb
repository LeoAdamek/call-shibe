require 'spec_helper'

describe CallShibe::TwilioHooks do

  include Rack::Test::Methods

  def app
    CallShibe::API
  end

  describe '/api/twilio/call-recieved' do
    it 'serves GET requests' do
      get '/api/twilio/call-received'

      last_response.body.should_not eq 404
      last_response.body.should_not eq 'Not Found'
    end

    it 'requires AccountSid , From and CallSid' do
      get '/api/twilio/call-received'

      last_response.status.should eq 400

      last_response.body.should =~ /AccountSid/
      last_response.body.should =~ /From/
      last_response.body.should =~ /CallSid/
      last_response.body.should =~ /is missing/
    end
  end

  describe '/api/twilio/conference-code' do
    it 'serves GET requests' do
      get '/api/twilio/conference-code'

      last_response.status.should_not eq 404
      last_response.body.should_not eq 'Not Found'
    end

    it 'requires AccountSid and Digits' do
      get '/api/twilio/conference-code'

      last_response.body.should =~ /AccountSid/
      last_response.body.should =~ /Digits/
      last_response.body.should =~ /is missing/
    end
  end

  describe '/api/twilio/call-status' do
    it 'serves GET requests' do
      get '/api/twilio/call-status'

      last_response.status.should_not eq 404
      last_response.status.should_not eq 'Not Found'
    end

    it 'requires AccountSid and CallSid' do
      get '/api/twilio/call-status'

      last_response.status.should eq 400

      last_response.body.should =~ /AccountSid/
      last_response.body.should =~ /CallSid/
      last_response.body.should =~ /is missing/
    end
  end

end
