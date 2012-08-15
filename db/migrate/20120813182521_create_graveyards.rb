class CreateGraveyards < ActiveRecord::Migration
  def change
    create_table :graveyards do |t|
      t.references :player
      t.timestamps
    end
  end
end
