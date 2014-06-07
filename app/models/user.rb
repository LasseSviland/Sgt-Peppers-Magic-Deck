class User < ActiveRecord::Base
  validates :username, uniqueness: true

  def password=(plaintext)
    self.password_hash = BCrypt::Password.create(plaintext)
  end

  def authenticate(plaintext_password)
    BCrypt::Password.new(self.password_hash) == plaintext_password
  end
end
