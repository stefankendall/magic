class Game < ActiveRecord::Base
  has_many :players
  has_one :turn
  has_one :stack

  attr_accessible :turn, :stack, :players

  def Game.new_game
    player1_library = Library.create_default_library
    player2_library = Library.create_default_library

    player1_hand = Hand.create()
    player2_hand = Hand.create()

    player1 = Player.create board: nil, hand: player1_hand, library: player1_library, graveyard: nil, order: 1, life_total: 20
    player2 = Player.create board: nil, hand: player2_hand, library: player2_library, graveyard: nil, order: 2, life_total: 20

    game = Game.create players: [player1, player2]
    game.create_stack stack_frames: []
    game.create_turn count: 1, phase: 'upkeep', player: player1
    game
  end

  def next_phase
    unless self.stack.is_empty?
      raise "error"
    end

    self.turn.next_phase

    if turn.draw_step?
      draw_card_for_current_player
      self.turn.next_phase
    end
  end

  def draw_card_for_current_player
    current_player = self.turn.player
    top_card = current_player.library.top_card
    if top_card.nil?
      other_player = self.players.find {|p| p != current_player }
      Result.create(winner: "Player #{other_player.order}", game: self)
    else
      current_player.hand.add_card top_card
    end
  end

  def as_json(options)
    options[:include] ||= [:players, :turn, :stack]
    super(options)
  end
end

