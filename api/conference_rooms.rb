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
        requires :name,
                 type: String,
                 desc: 'Room Name'

        requires :join_code,
                 type: String,
                 desc: 'Joining Code'

        if ::CallShibe.config['conference_rooms']['multi_number']
          requires :inbound_number,
                   type: String,
                   desc: 'Number this call will come in to'
        end

        optional :beep,
                 type: String,
                 desc: 'Change Beep settings'

        optional :wait_audio,
                 type: String,
                 desc: 'URL to audio file to play while waiting for start'

        optional :max_participents,
                 type: Integer,
                 desc: 'Maximum number of participants'

        optional :trim_silence,
                 type: Boolean,
                 desc: 'Trim silence from audio files'

        optional :record,
                 type: Boolean,
                 desc: 'record calls to this room'

      end
      put do
        require_authentication!

        @room = ::ConferenceRoom.create(
                                        name: params[:name],
                                        join_code: params[:join_code],
                                        room_options: {
                                          beep: params[:beep],
                                          wait_audio: params[:wait_audio],
                                          record: params[:record],
                                          max_participents: params[:max_participents],
                                          trim_silence: params[:trim_silence]
                                        }
                                        )

        { data: @room, saved: @room.save }
      end

      desc 'Delete a conference room by ID'
      params do
        requires :id , type: String, desc: 'Room ID'
      end
      delete ':id' do
        require_authentication!

        @room = ::ConferenceRoom.find(id: params[:id])

        { id: params[:id],
          deleted: true }
      end

      desc 'Get the calls for a room'
      params do
        requires :name, type: String, desc: 'Room Name'
      end
      get '/:name/calls' do
        require_authentication!

        ::Call.find_by(room_name: params[:id])
      end

    end
  end
end
