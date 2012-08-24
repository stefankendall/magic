require 'ruby/rules/rule_implementation'

class CombatDamage < RuleImplementation
  def responds_to_event?(event)
    event.action == "combat damage"
  end

  def respond_to_event(event)
    attacking_cards = event.game.turn.player.board.cards.find_all do |card|
      card.attacking
    end

    total_damage = 0
    attacking_cards.each do |card|
      total_damage += card.card_archetype.power
    end

    other_player = event.game.players.find { |player| player != event.game.turn.player }
    other_player.life_total -= total_damage
    other_player.save
  end
end
