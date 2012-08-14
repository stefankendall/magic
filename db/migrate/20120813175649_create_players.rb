class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :player_state
      t.timestamps
    end
  end
end
