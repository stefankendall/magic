require 'ruby/rules/rule_implementation'

class ResolveCreature < RuleImplementation
  def responds_to_event?(event)
     event.action == 'resolve' and event.card.has_rule? 'Creature'
  end

  def respond_to_event(event)
    unless event.game.stack.top_card == event.card
      raise InvalidPlayError.new "Creature must be the top spell on the stack"
    end

    resolve_creature event
  end

  def resolve_creature event
    event.game.stack.remove_top_card
    event.player.board.add_card event.card
  end
end
