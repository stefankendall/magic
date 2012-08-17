class TurnAction < ActiveRecord::Base
  belongs_to :player
  belongs_to :card
  belongs_to :turn
  attr_accessible :name, :player, :card

  def play_action?
    name == "play"
  end
end
