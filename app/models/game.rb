class Game < ActiveRecord::Base
  has_many :player_states
  has_one :turn
  has_one :stack

  attr_accessible :turn, :stack, :player_states

  def Game.new_game
    player1 = Player.create
    player2 = Player.create

    player1_library = Library.create_default_library
    player2_library = Library.create_default_library

    player_state1 = PlayerState.create player: player1, board: nil, hand: nil, library: player1_library, graveyard: nil
    player_state2 = PlayerState.create player: player2, board: nil, hand: nil, library: player2_library, graveyard: nil

    game = Game.create player_states: [player_state1, player_state2]
    game.create_stack stack_frames: []
    game.create_turn count: 1, phase: 'upkeep', player: player1
    game
  end

  def as_json(options)
    options[:include] ||= [:player_states, :turn, :stack]
    options[:except] ||= [:created_at, :updated_at]
    super(options)
  end
end
