
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
          # Replace an opening space with a + so they caller will match when they call.
          phone_number: params[:phone_number].sub(/^\s/, '+'),
          name: params[:name],
          auto_join_room: params[:auto_join_room]
        }

        # Create the new caller
        @caller = ::Caller.new data
        
        # Echo back the data with a true/false for save
        {data: @caller, saved: @caller.save}
      end

      desc 'Get a caller by phone number'
      params do
        requires :phone_number, type: String , desc: "The Caller's phone number"
      end
      get ':phone_number' do
        ::Caller.find_by( :phone_number => params[:phone_number])
      end

      desc 'Update a caller'
      params do
        requires :phone_number, type: String, desc: "The caller's phone number"
      end
      post ':phone_number' do
        @caller = ::Caller.find_by(:phone_number => params[:phone_number])
        
        error! "Not Implimented" , 404
      end

    end
    
  end
end
