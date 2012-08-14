class Card < ActiveRecord::Base
  has_one :card_archetype
  attr_accessible :card_archetype
  attr_accessor :card_archetype

  validates :card_archetype, :presence => true
end
