module CallShibe
  class Call
    include Mongoid::Document

    field :call_started_at , type: Time
    field :call_ended_at   , type: Time

    field :duration_minutes , type: Integer
    field :room_name , type: String

    belongs_to :caller
  end
end
