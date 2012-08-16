class CreateStackFrames < ActiveRecord::Migration
  def change
    create_table :stack_frames do |t|
      t.references :stack
      t.timestamps
    end
  end
end
