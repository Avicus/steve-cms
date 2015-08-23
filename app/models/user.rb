class User < ActiveRecord::Base
  has_secure_password
  has_many :usernames

  attr_accessor :password_confirmation
  attr_accessor :username

  validate :unique_username

  after_create :add_username

  def name
    usernames.last.name
  end

  def unique_username
    if Username.find_by_name(username)
      errors.add(:username, "is already a registered user")
    end
  end

  def add_username
    Username.create(:user => self, :name => username)
  end

  def self.find_by_identifier(type, identifier)
    if type == "username"
      username = Username.where(:name => identifier).order("created_at DESC").limit(1).first
      return username ? username.user : nil
    end
  end
end
