class CreateStackFrames < ActiveRecord::Migration
  def change
    create_table :stack_frames do |t|

      t.timestamps
    end
  end
end
