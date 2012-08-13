class CreateGraveyards < ActiveRecord::Migration
  def change
    create_table :graveyards do |t|

      t.timestamps
    end
  end
end
