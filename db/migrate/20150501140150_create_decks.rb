class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :subject

      t.timestamps null: false
    end
  end
end
