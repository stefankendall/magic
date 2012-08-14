class CreateStacks < ActiveRecord::Migration
  def change
    create_table :stacks do |t|

      t.references :game
      t.timestamps
    end
  end
end
