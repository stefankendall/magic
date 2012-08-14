class Graveyard < ActiveRecord::Base
  belongs_to :player_state
  has_many :cards
end
