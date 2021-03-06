module CallShibe
  ##
  # Callers interface for the CallShibe API
  #
  class Callers < Grape::API
    resource :callers do

      desc 'Get the callers list'
      get do

        require_authentication!

        ::Caller.all
      end

      desc 'Create a new caller' ,
           notes: <<-NOTE
* The `:phone_number` field must be passed in [E.164 format](http://en.wikipedia.org/wiki/E.164)
* The `:name` field does not need to be unique and it not used as an identifier but must be spplied.
* The `:auto_join_room` field, if spplied will be the name of the room this caller will be automatically forwarded to
  If not supplied the caller will be prompted for a code.
NOTE

      params do
        requires :phone_number  , type: String, desc: 'Caller Phone Number'
        requires :name          , type: String, desc: 'Caller Name'
        optional :auto_join_room, type: String, desc: 'Room for caller to auto-join'
      end
      put  do

        require_authentication!

        data = {
          # Replace an opening space with a + so they caller will match when they call.
          phone_number: params[:phone_number].sub(/^\s/, '+'),
          name: params[:name],
          auto_join_room: params[:auto_join_room]
        }

        # Create the new caller
        @caller = ::Caller.new data

        # Echo back the data with a true/false for save
        { data: @caller, saved: @caller.save }
      end

      desc 'Get a caller by phone number'
      params do
        requires :phone_number, type: String , desc: "The Caller's phone number"
      end
      get ':phone_number' do
        require_authentication!

        ::Caller.find_by(phone_number: params[:phone_number])
      end

      desc 'Update a caller'
      params do
        requires :phone_number, type: String, desc: "The caller's phone number"
        optional :name , type: String , desc: 'New name'
        optional :auto_join_room , type: String, desc: 'New Auto Join Room'
        optional :new_phone_number, type: String, desc: 'New Phone number for the caller'
      end
      post ':phone_number' do
        require_authentication!

        @caller = ::Caller.find_by(phone_number: params[:phone_number])

        error! 'Caller not found' , 404 if @caller.nil?

        @caller.name = params[:name] if params[:name]
        @caller.auto_join_room = params[:auto_join_room] if params[:auto_join_room]

        { success: @caller.save }

      end

      desc 'Delete A Caller'
      params do
        requires :phone_number, type: String, desc: 'Phone number of caller to delete'
      end
      delete ':phone_number' do

        require_authentication!

        @caller = ::Caller.find_by(phone_number: params[:phone_number])

        { phone_number: params[:phone_number],
          id: @caller.id,
          deleted: @caller.delete }

      end

    end
  end
end
