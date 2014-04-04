module CallShibe
  module Models
    class Caller
      include Mongoid::Document

      field :phone_number , type: String
      field :name         , type: String

      field :auto_join_room , type: String

      field :minutes_called , type: Integer
      field :last_called_at , type: Time

      field :created_at , type: Time
      field :modified_at , type: Time
      

      has_many :calls
    end
  end
end
