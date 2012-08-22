require 'ruby/rules/rule_implementation'
class EndCombat < RuleImplementation
  def responds_to_event?(event)
    event.action == "end combat"
  end

  def respond_to_event(event)
    event.game.turn.player.board.cards.each do |card|
      card.attacking = false
      card.save
    end
  end
end
