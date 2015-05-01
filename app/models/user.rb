class User < ActiveRecord::Base
  include BCrypt

  has_many :rounds
  has_many :decks
  has_many :attempts, through: :decks

  validates :username, length: { minimum: 4 }

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end

  def self.authenticate(login_hash)
    @user = User.find_by_username(login_hash[:username])
    if @user && @user.password == login_hash[:password]
      @user.id
    else
      nil
    end
  end

end
