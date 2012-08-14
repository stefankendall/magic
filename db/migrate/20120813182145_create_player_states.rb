class CreatePlayerStates < ActiveRecord::Migration
  def change
    create_table :player_states do |t|
      t.references :game
      t.timestamps
    end
  end
end
