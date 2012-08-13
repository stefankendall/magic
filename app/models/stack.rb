class Stack < ActiveRecord::Base
  has_many :stack_frames

  attr_accessor :stack_frames
  attr_accessible :stack_frames
end
