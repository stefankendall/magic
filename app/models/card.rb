class Card < ActiveRecord::Base
  belongs_to :card_archetype
  belongs_to :card_holder, polymorphic: true

  attr_accessible :card_archetype

  validates :card_archetype, :presence => true
end
