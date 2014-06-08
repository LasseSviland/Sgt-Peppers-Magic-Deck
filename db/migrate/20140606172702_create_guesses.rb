class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :tries, default: 0
      t.boolean :guessed
      t.belongs_to :round
      t.belongs_to :card

      t.timestamps
    end
  end
end
