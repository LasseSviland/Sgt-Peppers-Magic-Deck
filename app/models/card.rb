class Card < ActiveRecord::Base
  has_many :guesses
  belongs_to :deck
  # Remember to create a migration!
end
