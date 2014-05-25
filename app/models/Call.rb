class Call
  include Mongoid::Document

  field :call_started_at , type: Time
  field :call_ended_at   , type: Time

  field :call_sid , type: String

  field :duration_seconds , type: Integer
  field :room_name , type: String

  field :call_status

  field :created_at , type: Time , default: -> { Time.now }

  belongs_to :caller

  def add_action(action_data = {})
    action_data[:timestamp] = Time.now

    [:actions] << action_data

    save
  end
end
