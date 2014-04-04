class Call
  include Mongoid::Document

  field :call_started_at , type: Time
  field :call_ended_at   , type: Time

  field :call_sid , type: String
  
  field :duration_seconds , type: Integer
  field :room_name , type: String

  field :call_status
  
  belongs_to :caller
end

