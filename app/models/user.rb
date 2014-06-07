class User < ActiveRecord::Base
  validates :username, uniqueness: true
  has_many :rounds
  has_many :guesses, through: :rounds
  
  def self.authenticate(username, password)
    @user = self.find_by(username: username)
    if @user && @user.password == password
      return @user
    else
      return nil
    end
  end
end
