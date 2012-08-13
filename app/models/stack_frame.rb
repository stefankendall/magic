class StackFrame < ActiveRecord::Base
  has_one :card
  has_one :player
  has_many :cards

  attr_accessor :card, :player, :cards
  attr_accessible :card, :player, :cards
end
