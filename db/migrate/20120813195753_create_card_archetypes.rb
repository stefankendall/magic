class CreateCardArchetypes < ActiveRecord::Migration
  def change
    create_table :card_archetypes do |t|
      t.string :name
      t.integer :colorlessCost, :default => 0
      t.integer :greenCost, :default => 0
      t.integer :redCost, :default => 0
      t.integer :whiteCost, :default => 0
      t.integer :blueCost, :default => 0
      t.integer :blackCost, :default => 0
      t.integer :power, :default => 0
      t.integer :toughness, :default => 0

      t.timestamps
    end
  end
end
