class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :player_state
      t.references :turn
      t.timestamps
    end
  end
end
