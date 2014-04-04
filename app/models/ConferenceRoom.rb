class ConferenceRoom
  include Mongoid::Document

  field :name , type: String
  field :join_code , type: String
end
