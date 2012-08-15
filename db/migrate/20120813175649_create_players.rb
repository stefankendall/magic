class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :game
      t.references :turn
      t.integer :life_total
      t.integer :order
      t.timestamps
    end
  end
end
