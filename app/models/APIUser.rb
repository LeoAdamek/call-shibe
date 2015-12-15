=begin
API User
========

API User class,
This model controls access to the API.

=end
class APIUser
  include Dynamoid::Document

  field :name , :string
  field :access_token , :string , default: -> { self.create_access_token }

  field :is_enabled , :boolean , default: true

  field :created_at , :datetime , default: -> { Time.now }
  field :modified_at , :datetime

  field :last_accessed_at , :datetime

  # Validations
  validates :name, presence: true
  validates :access_token, presence: true

  ## Access Token Generation
  def self.create_access_token
    (0...32).map { ('a'..'z').to_a[rand(26)] }.join
  end

  ## Authentication Method
  def self.authenticate(access_token)
    user = find_by(access_token: access_token , is_enabled: true)

    user || false
  end
end
