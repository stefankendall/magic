require 'ruby/rules/rule_implementation'
class TapForGreen < RuleImplementation
  def responds_to_event?(event)
    event.tap_for_green?
  end

  def respond_to_event(event)
    unless event.player.board.has_card? event.card
      raise InvalidPlayError.new "Lands must be tapped from the board"
    end

    if event.card.tapped
      raise InvalidPlayError.new "Tapped cards cannot be tapped for green"
    end

    unless event.card.has_rule? "tap for green"
      raise InvalidPlayError.new "Card cannot be tapped for green"
    end

    tap_for_green event
  end

  def tap_for_green(event)
    event.card.update_attributes :tapped => true
    event.player.mana_pool.add_green 1
  end
end
