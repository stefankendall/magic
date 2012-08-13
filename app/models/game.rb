class Game < ActiveRecord::Base
  has_many :player_states
  has_one :turn
  has_one :stack

  attr_accessor :turn, :stack, :player_states
  attr_accessible :turn, :stack, :player_states

  def Game.new_game
    player1 = Player.create
    player2 = Player.create

    player_state1 = PlayerState.create player: player1, board: [], hand: [], library: [], graveyard: []
    player_state2 = PlayerState.create player: player2, board: [], hand: [], library: [], graveyard: []

    stack = Stack.create stack_frames: []

    turn = Turn.create count: 1, phase: 'upkeep', player: player1
    Game.create player_states: [player_state1, player_state2], stack: stack, turn: turn
  end

  def as_json(options)
    super(:include => [:player_states, :turn, :stack])
  end
end
