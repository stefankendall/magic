class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.references :player_state
      t.timestamps
    end
  end
end
