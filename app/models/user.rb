class User < ActiveRecord::Base

  has_many :rounds
  has_many :decks
  has_many :attempts, through: :decks

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end

  def self.authenticate(email,password_guess)
    @user = User.find_by_email(email)
    if @user && @user.password == password_guess
      @user
    else
      nil
    end
  end

end
