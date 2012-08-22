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
    player = event.game.stack.get_casting_player event.card
    event.game.stack.remove_top
    player.board.add_card event.card
  end
end
