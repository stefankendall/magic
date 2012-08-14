class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.string :phase
      t.integer :count

      t.references :game
      t.timestamps
    end
  end
end
