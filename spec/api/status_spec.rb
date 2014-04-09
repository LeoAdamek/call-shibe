require 'spec_helper'

describe CallShibe::Status do

  include Rack::Test::Methods

  def app
    CallShibe::API
  end

  it 'serves GET /api/status' do
    get '/api/status'
    last_response.status.should eq 200
  end

  it 'returns an object where all values are true' do
    get '/api/status'
    JSON.load(last_response.body).values.uniq.should eq [true]
  end

end
