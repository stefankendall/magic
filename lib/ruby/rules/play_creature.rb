require 'ruby/rules/rule_implementation'
class PlayCreature < RuleImplementation
  def responds_to_event?(event)
    event.card.has_rule?('Creature') && event.action == 'play'
  end

  def respond_to_event(event)
    unless event.player.hand.has_card? event.card
      raise InvalidPlayError.new "Creature must be played from the hand"
    end

    unless event.player == event.game.turn.player
      raise InvalidPlayError.new "Creatures can only be played during your turn"
    end

    unless event.game.turn.main_phase?
      raise InvalidPlayError.new "Creatures can only be played during a main phase"
    end

    unless event.game.stack.is_empty?
      raise InvalidPlayError.new "Creatures cannot be played when the stack is not empty"
    end

    play_creature event
  end

  def play_creature event
    event.player.mana_pool.pay_for event.card
    event.game.stack.add_card event.card, event.player
    event.game.turn.save_turn_action TurnAction.create(card: event.card, player: event.player, name: 'play')
  end
end
