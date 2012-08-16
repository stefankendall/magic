class Card < ActiveRecord::Base
  belongs_to :card_archetype
  belongs_to :card_holder, polymorphic: true

  attr_accessible :card_archetype, :position

  validates :card_archetype, :presence => true

  def has_rule?(rule)
    card_archetype.rules.select {|r| r.name == rule}.present?
  end
end
