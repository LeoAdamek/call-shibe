require 'spec_helper'

describe CallShibe::Callers do
  include Rack::Test::Methods

  def app
    CallShibe::API
  end

  describe 'GET /api/callers' do

    it 'serves GET requests' do
      get '/api/callers'

      last_response.status.should_not eq 404
      last_response.body.should_not eq 'Not Found'
    end

    it 'requires authentication' do
      get '/api/callers'

      last_response.status.should eq 401
    end

  end
end
