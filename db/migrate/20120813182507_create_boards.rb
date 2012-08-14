class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.references :player_state
      t.timestamps
    end
  end
end
