class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :tries, default: 0
      t.boolean :guessed, default: false 
      t.belongs_to :round

      t.timestamps
    end
  end
end
