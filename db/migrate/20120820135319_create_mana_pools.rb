class CreateManaPools < ActiveRecord::Migration
  def change
    create_table :mana_pools do |t|
      t.integer :green, :default => 0
      t.integer :white, :default => 0
      t.integer :red, :default => 0
      t.integer :blue, :default => 0
      t.integer :black, :default => 0
      t.integer :colorless, :default => 0

      t.references :player
      t.timestamps
    end
  end
end
