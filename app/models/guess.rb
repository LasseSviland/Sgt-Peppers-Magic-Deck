class Guess < ActiveRecord::Base
  # Remember to create a migration!
  # has_one :card
  belongs_to :card
  belongs_to :round
end
