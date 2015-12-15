module CallShibe
  module TwilioCallbacks

    class WaitAudio < Grape::API

      # Special Sauce.
      FRIDAY    = 5
      RB_FRIDAY = "http://call-shibe-assets.s3.amazonaws.com/wait-audio/friday.mp3"

      desc 'Twilio API Hook for getting the Wait Audio'
      get 'wait-audio' do


        # Easter Egg:
        # On Fridays, change the music to something more...
        # ... appropreate.
        if Time.now.wday == FRIDAY
          return Twilio::TwiML::Response.new do |r|
            r.Play RB_FRIDAY
          end
        end

        # Play a shuffled playlist
        music_urls = ::CallShibe::Configuration.wait_audio

        Twilio::TwiML::Response.new do |r|
          music_urls.shuffle.each do |music|
            r.Play music
          end
        end

      end
    end
  end
end
