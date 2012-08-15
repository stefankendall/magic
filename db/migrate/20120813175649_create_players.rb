class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :game
      t.references :turn
      t.timestamps
    end
  end
end
