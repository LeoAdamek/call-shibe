=begin
API User
========

API User class,
This model controls access to the API.

=end
class APIUser
  include Mongoid::Document

  field :name , :type => String
  field :access_token , :type => String , :default => ->{ create_access_token }

  field :is_enabled , :type => Boolean , :default => true

  field :created_at , :type => Time , :default => -> { Time.now }
  field :modified_at , :type => Time
  
  field :last_accessed_at , :type => Time

  # Validations
  validates :name , :uniqueness => true, :presence => true
  validates :access_token , :uniqueness => true, :presence => true

  ## Access Token Generation
  def create_access_token
    (0...32).map { ('a'..'z').to_a[rand(26)] }.join
  end

  ## Authentication Method
  def self.authenticate(access_token)
    user = find_by( :access_token => access_token , :is_enabled => true )
    
    user || false
  end
  
end
