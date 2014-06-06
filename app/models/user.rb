class User < ActiveRecord::Base
  validates :username, uniqueness: true

  def self.authenticate(username, password)
    @user = self.find_by(username: username)
    if @user && @user.password == password
      return @user
    else
      return nil
    end
  end

end
