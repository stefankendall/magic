class Game < ActiveRecord::Base
  has_many :player_states
  has_one :turn
  attr_accessor :turn, :player_states
  attr_accessible :turn, :player_states

  def Game.new_game
    player1 = Player.create()
    player2 = Player.create()

    turn = Turn.new(count: 1, phase: 'upkeep', player: player1)
    Game.create(player_states: [], turn: turn)
  end

  def as_json(options)
    super(:include => [:turn, :player_states])
  end
end
