require 'ruby/rules/rule_implementation'
class DeclareAttackers < RuleImplementation
  def responds_to_event?(event)
    event.declare_attackers_action? && event.card.has_rule?("Creature") && event.game.turn.declare_attackers?
  end

  def respond_to_event(event)
    if event.card.tapped
      raise InvalidPlayError
    end

    unless event.player.board.has_card? event.card
      raise InvalidPlayError
    end

    if event.card.summoning_sick
      raise InvalidPlayError
    end

    event.card.attacking = true
    event.card.save
  end
end
