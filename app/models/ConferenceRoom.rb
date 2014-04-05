class ConferenceRoom
  include Mongoid::Document

  field :name , type: String
  field :join_code , type: String

  index :name => 1
  index :join_code => 1
end
