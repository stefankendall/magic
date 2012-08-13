class Turn < ActiveRecord::Base
  has_one :player
  attr_accessor :count, :phase, :player
  attr_accessible :count, :phase, :player
end
