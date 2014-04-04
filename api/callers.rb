
module CallShibe
  ##
  # Callers interface for the CallShibe API
  #
  class Callers < Grape::API

    resource :callers do

      desc 'Get the callers list'
      get do
        ::Caller.all
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

        @caller = ::Caller.new (data)
        
        {data: @caller, saved: @caller.save}
      end

      desc 'Get a caller'
      params do
        requires :id , type: String
      end
      get ':id' do
        ::Caller.find(params[:id])
      end

    end
    
  end
end
