class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :round_id
      t.integer :card_id
      t.boolean :correct
      t.string  :submission

      t.timestamps null: false
    end
  end
end
