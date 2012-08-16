class Stack < ActiveRecord::Base
  belongs_to :game
  has_many :stack_frames

  attr_accessible :stack_frames

  def is_empty?
    !stack_frames.any?
  end
end
