class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :board
      t.references :library
      t.references :hand
      t.references :graveyard
      t.references :card_archetype
      t.timestamps
    end
  end
end
