class StackFrame < ActiveRecord::Base
  has_one :card
  has_one :player
  has_many :targets, :class_name => 'Card'

  attr_accessor :card, :player, :targets
  attr_accessible :card, :player, :targets
end
