class Game < ActiveRecord::Base
  has_many :players
  has_one :turn
  has_one :stack

  attr_accessible :turn, :stack, :players

  def Game.new_game
    player1_library = Library.create_default_library
    player2_library = Library.create_default_library

    player1_hand = Hand.create
    player2_hand = Hand.create

    player1 = Player.create board: Board.create, hand: player1_hand, library: player1_library, graveyard: Graveyard.create, order: 1, life_total: 20, mana_pool: ManaPool.create
    player2 = Player.create board: Board.create, hand: player2_hand, library: player2_library, graveyard: Graveyard.create, order: 2, life_total: 20, mana_pool: ManaPool.create

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

  def resolve_top_of_stack
    RuleNotifier.instance.emit Event.new card: stack.top_card, game: self, action: 'resolve'
  end

  def play_card(card)
    emit_event card, 'play'
  end

  def activate_ability(card, ability)
    emit_event card, ability
  end

  def emit_event(card, event_type)
    event = Event.new card: card, player: card.card_holder.player, game: self, action: event_type
    RuleNotifier.instance.emit event
  end

  def draw_card_for_current_player
    current_player = self.turn.player
    top_card = current_player.library.top_card
    if top_card.nil?
      other_player = self.players.find { |p| p != current_player }
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

