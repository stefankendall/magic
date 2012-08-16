class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :name
      t.timestamps
    end

    create_table :card_archetypes_rules do |t|
      t.references :card_archetype
      t.references :rule
    end
  end
end
