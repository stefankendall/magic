class PlayerState < ActiveRecord::Base
  has_one :player
  has_one :board
  has_one :hand
  has_one :library
  has_one :graveyard
  attr_accessor :player, :board, :hand, :library, :graveyard
  attr_accessible :player, :board, :hand, :library, :graveyard
end
