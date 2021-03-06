class ConferenceRoom
  include Mongoid::Document
  field :name , type: String
  field :join_code , type: String
  field :inbound_number , type: String

  validates :join_code , length: {is: 4}, presence: true, uniqueness: true
  validates :name , presence: true

  # Need to make this optional!
  embeds_one :room_options , class_name: 'ConferenceRoomOptions'

  index name: 1
  index join_code: 1

  def join_options
    options = {}
    options.merge! ::CallShibe::Configuration.conference_rooms.default_options
  end

  ##
  # Find a conference rom by joining code, and inbound number if multi-number is enabled.
  #
  # @param fields [Hash] Fields to search by
  def self.find_room_for_call(fields = {})
    if ::CallShibe::Configuration.conference_rooms.multi_number
      find_by(join_code: fields[:join_code], inbound_number: fields[:inbound_number])
    else
      find_by(join_code: find_by[:join_code])
    end
  end
end
