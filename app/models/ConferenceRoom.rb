class ConferenceRoom
  include Dynamoid::Document

  table :name => :conference_rooms,
        :key => :room_id

  field :name , :string
  field :join_code , :string, unique: true, index: true
  field :beep  , :string
  field :wait_audio , :string
  field :record , :boolean, default: false
  field :max_participents , :integer, default: 10
  field :trim_silence , :boolean, default: true

  if ::CallShibe::Configuration.conference_rooms.multi_number
    field :inbound_number , :string
  end

  validates :beep , inclusion: { in: %w(true false onEnter onExit) }

  validates :max_participents , numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 40
  }
  validates :join_code , length: {is: 4}, presence: true
  validates :name , presence: true

  ##
  #
  # Get the join options, merges the default options with the overrides
  # for this room.
  def join_options
    ::CallShibe::Configuration.conference_rooms.default_options.merge(
                                                                   beep: beep,
                                                                   trim_silence: trim_silence,
                                                                   max_participents: max_participents,
                                                                   record: record,
                                                                   wait_audio: wait_audio
    )
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
