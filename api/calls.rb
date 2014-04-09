module CallShibe
  class Calls < Grape::API

    desc 'Read-only API for Calls'
    resource :calls do

      desc 'Get all Calls'
      get do
        require_authentication!
        ::Call.all
      end

      desc "Get calls from a specific number"
      params do
        requires :phone_number, type: String, desc: "Phone number to get calls from"
      end
      get '/from/:phone_number' do
        require_authentication!

        @caller = ::Caller.find_by(:phone_number => params[:phone_number])
        
        if @caller
          @calls = ::Call.find_by(:caller => @caller)
        else
          @calls = ::Call.find_by(:phone_number => params[:phone_number])
        end

        @calls
      end

    end

  end
end
