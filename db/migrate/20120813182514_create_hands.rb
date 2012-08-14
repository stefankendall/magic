class CreateHands < ActiveRecord::Migration
  def change
    create_table :hands do |t|
      t.references :player_state
      t.timestamps
    end
  end
end
