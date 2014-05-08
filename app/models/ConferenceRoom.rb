class ConferenceRoom
  include Mongoid::Document

  field :name , type: String
  field :join_code , type: String
  field :inbound_number , type: String

  embeds_one :room_options , class_name: "ConferenceRoomOptions"

  index :name => 1
  index :join_code => 1

  def join_options
    room_options.merge! ::CallShibe.config['conference_rooms']['default_options']
  end
end
