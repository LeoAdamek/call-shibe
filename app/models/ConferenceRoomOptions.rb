class ConferenceRoomOptions

  include Mongoid::Document

  field :beep  , type: String  , default: true

  field :wait_audio , type: String

  field :record , type: Boolean , default: false
  field :max_participents , type: Integer

  field :trim_silence , type: Boolean

  validates :beep , inclusion: { in: %w(true false onEnter onExit) }

  validates :max_participents , numericality: { 
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 40
  }

  embedded_in :conference_room
end
