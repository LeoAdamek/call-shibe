class Call

  include Dynamoid::Document

  table :name => :calls,
        :key => :call_id

  field :call_started_at , :datetime
  field :call_ended_at   , :datetime
  field :call_sid , :string
  field :duration_seconds , :integer
  field :room_name , :string
  field :room_id , :string
  field :created_at , :datetime, default: -> { Time.now }
  field :actions, :serialized

  belongs_to :caller

  def add_action(action_data = {})
    action_data[:timestamp] = Time.now

    [:actions] << action_data

    save
  end
end
