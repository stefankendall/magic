class Game < ActiveRecord::Base
  has_many :players
  has_one :turn
  has_one :stack

  attr_accessible :turn, :stack, :players

  def Game.new_game
    player1_library = Library.create_default_library
    player2_library = Library.create_default_library

    player1 = Player.create board: nil, hand: nil, library: player1_library, graveyard: nil
    player2 = Player.create board: nil, hand: nil, library: player2_library, graveyard: nil

    game = Game.create players: [player1, player2]
    game.create_stack stack_frames: []
    game.create_turn count: 1, phase: 'upkeep', player: player1
    game
  end

  def as_json(options)
    options[:include] ||= [:players, :turn, :stack]
    options[:except] ||= [:created_at, :updated_at]
    super(options)
  end
end
