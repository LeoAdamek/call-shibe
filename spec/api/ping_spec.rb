require 'spec_helper'

describe CallShibe::Ping do
  include Rack::Test::Methods

  def app
    CallShibe::API
  end

  it 'serves GET /api/ping and returns {"ping":"pong"}' do
    get "/api/ping"
    last_response.status.should eq 200
    last_response.body.should eq( { ping: "pong"}.to_json )
  end
end
