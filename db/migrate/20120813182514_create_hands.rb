class CreateHands < ActiveRecord::Migration
  def change
    create_table :hands do |t|
      t.references :player
      t.timestamps
    end
  end
end
