module CallShibe
  class ConferenceRooms < Grape::API
    
    resource :rooms do

      desc 'Get all conference rooms'
      get do
        ::ConferenceRoom.all
      end

      desc "Create a new conference room"
      params do
        requires :name , type: String, desc: "Room Name"
        requires :join_code , type: String, desc: "Joining Code"
      end
      put do
        @room = ::ConferenceRoom.create(
                                        :name => params[:name],
                                        :join_code => params[:join_code]
                                        )

        {data: @room, saved: @room.save}
      end


    end
  end
end
