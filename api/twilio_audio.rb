class CallShibe::TwilioCallbacks::WaitAudio < Grape::API

  # Special Sauce.
  FRIDAY    = 5
  RB_FRIDAY = "http://call-shibe-assets.s3.amazonaws.com/wait-audio/friday.mp3"

  DEFAULT_WAIT_AUDIO = "http://call-shibe-assets.s3.amazonaws.com/wait-audio/default.mp3"
  
  desc 'Twilio API Hook for getting the Wait Audio'
  params do
  end
  get 'wait-audio' do

    audio_url = DEFAULT_WAIT_AUDIO

    # Easter Egg:
    # On Fridays, change the music to something more...
    # ... appropreate.
    audio_url = RB_FRIDAY if Time.now.wday == FRIDAY

    Twilio::TwiML::Response.new do |r|
      r.Play audio_url
    end
  end
  
end
