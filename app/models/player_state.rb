class PlayerState < ActiveRecord::Base
  belongs_to :game
  has_one :player
  has_one :board
  has_one :hand
  has_one :library
  has_one :graveyard
  attr_accessible :player, :board, :hand, :library, :graveyard
end
