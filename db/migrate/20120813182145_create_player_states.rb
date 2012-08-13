class CreatePlayerStates < ActiveRecord::Migration
  def change
    create_table :player_states do |t|

      t.timestamps
    end
  end
end
