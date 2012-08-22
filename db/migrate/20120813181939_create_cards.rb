class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :card_holder, :polymorphic => true
      t.references :card_archetype
      t.integer :position
      t.boolean :tapped
      t.boolean :summoning_sick
      t.boolean :attacking

      t.timestamps
    end
  end
end
