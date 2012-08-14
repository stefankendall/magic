class StackFrame < ActiveRecord::Base
  has_one :card
  has_one :player
  has_many :targets, :class_name => 'Card'

  attr_accessible :card, :player, :targets
end
