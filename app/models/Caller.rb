class Caller
  include Mongoid::Document

  field :phone_number , type: String

  field :name         , type: String
  field :auto_join_room , type: String

  field :minutes_called , type: Integer , default: 0
  field :last_called_at , type: Time

  field :created_at , type: Time
  field :modified_at , type: Time
  
end

