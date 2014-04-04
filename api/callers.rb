
module Konfrence
  ##
  # Callers interface for the Konfrence API
  #
  class Callers < Grape::API

    resource :callers do

      desc 'Get the callers list'
      get do
        ::Konfrence::Models::Caller.all
      end

      desc 'Create a new caller'
      params do
        requires :phone_number  , type: String, desc: "Caller Phone Number"
        requires :name          , type: String, desc: "Caller Name"
        optional :auto_join_room, type: String, desc: "Room for caller to auto-join"
      end
      put do
        data = {
          phone_number: params[:phone_number],
          name: params[:name],
          auto_join_room: params[:auto_join_room]
        }

        ::Konfrence::Models::Caller.create(data)
      end

      desc 'Get a caller'
      params do
        requires :id , type: String
      end
      get ':id' do
        ::Konfrence::Models::Caller.find(:id => params[:id])
      end

    end
    
  end
end
