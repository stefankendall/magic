class Turn < ActiveRecord::Base
  has_one :player
  belongs_to :game
  attr_accessible :count, :phase, :player
end
