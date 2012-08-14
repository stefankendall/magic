class CreateCardArchetypes < ActiveRecord::Migration
  def change
    create_table :card_archetypes do |t|
      t.string :name
      t.integer :colorlessCost
      t.integer :greenCost
      t.integer :redCost
      t.integer :whiteCost
      t.integer :blueCost
      t.integer :blackCost
      t.integer :power
      t.integer :toughness

      t.timestamps
    end
  end
end
