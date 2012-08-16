class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :winner
      t.references :game

      t.timestamps
    end
  end
end
