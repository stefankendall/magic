class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.references :player
      t.timestamps
    end
  end
end
