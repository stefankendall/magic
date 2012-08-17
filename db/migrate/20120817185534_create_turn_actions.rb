class CreateTurnActions < ActiveRecord::Migration
  def change
    create_table :turn_actions do |t|
      t.string :name
      t.references :player
      t.references :card
      t.references :turn

      t.timestamps
    end
  end
end
