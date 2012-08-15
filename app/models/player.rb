class Player < ActiveRecord::Base
  belongs_to :game
  belongs_to :turn
  has_one :board
  has_one :hand
  has_one :library
  has_one :graveyard
  attr_accessible :board, :hand, :library, :graveyard
end
