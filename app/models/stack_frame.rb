class StackFrame < ActiveRecord::Base
  has_one :card, as: :card_holder
  has_one :player
  has_many :targets, as: :card_holder, :class_name => "Card"
  belongs_to :stack

  attr_accessible :card, :player, :targets
end
