module CallShibe
  class ConferenceRooms < Grape::API
    
    resource :rooms do

      desc 'Get all conference rooms'
      get do
        require_authentication!

        ::ConferenceRoom.all
      end

      desc 'Create a new conference room'
      params do
        requires :name , type: String, desc: "Room Name"
        requires :join_code , type: String, desc: "Joining Code"
      end
      put do
        require_authentication!

        @room = ::ConferenceRoom.create(
                                        :name => params[:name],
                                        :join_code => params[:join_code]
                                        )

        {data: @room, saved: @room.save}
      end

      desc 'Delete a conference room by ID'
      params do
        requires :id , type: String, desc: 'Room ID'
      end
      delete ':id' do
        require_authentication!
        
        @room = ::ConferenceRoom.find(:id => params[:id])
        
        {:id => params[:id],
         :deleted => true}
      end

    end
  end
end
