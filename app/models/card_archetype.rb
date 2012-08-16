class CardArchetype < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :colorlessCost, :greenCost, :whiteCost, :redCost, :blueCost, :blackCost

  has_and_belongs_to_many :rules
  attr_accessible :rules

  attr_accessible :power, :toughness

  validates :name, :uniqueness => true
end
