class CreateGraveyards < ActiveRecord::Migration
  def change
    create_table :graveyards do |t|
      t.references :player_state
      t.timestamps
    end
  end
end
