class Turn < ActiveRecord::Base
  has_one :player
  attr_accessible :count, :phase
end
