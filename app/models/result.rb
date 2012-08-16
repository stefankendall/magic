class Result < ActiveRecord::Base
  belongs_to :game
  attr_accessible :winner, :game
end
