class StackFrame < ActiveRecord::Base
  has_one :card
  has_one :player
  has_many :targets, as: :card_holder

  attr_accessible :card, :player, :targets
end
