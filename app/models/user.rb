class User < ActiveRecord::Base
  validates :username, uniqueness: true, length: {in: 3..25}

  has_many :rounds
  has_many :guesses, through: :rounds
  
  def self.authenticate(username, password)
    @user = self.find_by(username: username)
    if @user && @user.password_hash == password
      return @user
    else
      return nil
    end
  end
end
