class Card < ActiveRecord::Base
  belongs_to :card_archetype
  belongs_to :board
  belongs_to :library
  belongs_to :graveyard
  belongs_to :hand

  attr_accessible :card_archetype

  validates :card_archetype, :presence => true
end
