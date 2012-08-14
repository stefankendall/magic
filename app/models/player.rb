class Player < ActiveRecord::Base
  belongs_to :player_state
  belongs_to :turn
end
