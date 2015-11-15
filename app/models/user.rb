class User < ActiveRecord::Base
  has_secure_password
  has_many :usernames
  has_many :user_groups, :dependent => :delete_all

  attr_accessor :password_confirmation
  attr_accessor :username

  validate :unique_username

  after_create :add_username

  def name
    usernames.last.name
  end

  def unique_username
    if Username.find_by_name(username)
      errors.add(:username, 'is already a registered user')
    end
  end

  def add_username
    Username.create(:user => self, :name => username)
  end

  def self.find_by_identifier(type, identifier)
    if type == 'username'
      username = Username.where(:name => identifier).order('created_at DESC').limit(1).first
      return username ? username.user : nil
    elsif type == 'email'
      user = User.where(:email => identifier).order('created_at DESC').limit(1).first
      return user
    end
  end

  def self.search_by_identifier(type, identifier)
    if type == 'username'
      usernames = Username.select(:id).where('name LIKE ?', "%#{identifier}%").order('created_at ASC')
      return User.where(:id => usernames.map(&:id))
    elsif type == 'email'
      users = User.where('email LIKE ?', "%#{identifier}%").order('created_at ASC')
      return users
    end
  end
end
