class Player < ActiveRecord::Base
  belongs_to :game
  belongs_to :turn
  has_one :board
  has_one :hand
  has_one :library
  has_one :graveyard
  has_one :mana_pool

  attr_accessible :board, :hand, :library, :graveyard, :life_total, :order, :mana_pool

  validates :mana_pool, :presence => true
end
