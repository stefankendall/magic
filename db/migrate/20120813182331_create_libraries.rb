class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.references :player
      t.timestamps
    end
  end
end
