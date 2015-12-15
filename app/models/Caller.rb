class Caller
  include Dynamoid::Document

  table :name => :callers,
        :key => :phone_number

  field :phone_number , :string

  field :name         , :string
  field :auto_join_room_id , :integer

  # These fields not currently used.
  field :minutes_called , :integer , default: 0
  field :last_called_at , :datetime
  field :created_at , :datetime
  field :modified_at , :datetime

  validates :name,
            presence: true

  # Performs a basic E.164 format check
  validates :phone_number,
            presence: true,
            uniqueness: true,
            format: {
              with: /^\+\d{10,14}$/
            }
end
