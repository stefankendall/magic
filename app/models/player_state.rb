class PlayerState < ActiveRecord::Base
  has_one :player
  has_one :board
  has_one :hand
  has_one :library
  has_one :graveyard
end
