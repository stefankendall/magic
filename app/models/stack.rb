class Stack < ActiveRecord::Base
  belongs_to :game
  has_many :stack_frames

  attr_accessible :stack_frames
end
