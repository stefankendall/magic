class CardArchetype < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :colorlessCost, :greenCost, :whiteCost, :redCost, :blueCost, :blackCost
  has_many :types
  has_many :rules
  attr_accessible :power, :toughness

  validates :name, :uniqueness => true
end
