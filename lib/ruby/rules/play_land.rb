require 'ruby/rules/rule_implementation'
class PlayLand < RuleImplementation
  def responds_to_event?(event)
    event.play_action? && event.card.has_rule?("Land")
  end

  def respond_to_event(event)
    unless event.player.hand.has_card? event.card
      raise InvalidPlayError.new "Lands must be played from the hand"
    end

    unless event.player == event.game.turn.player
      raise InvalidPlayError.new "Lands can only be played during your turn"
    end

    unless event.game.turn.main_phase?
      raise InvalidPlayError.new "Lands can only be played during a main phase"
    end

    unless event.game.stack.is_empty?
      raise InvalidPlayError.new "Lands cannot be played when the stack is not empty"
    end

    if lands_have_been_played_this_turn event
      raise InvalidPlayError.new "Only one land can be played per turn"
    end

    play_land event
  end

  def lands_have_been_played_this_turn(event)
    turn_actions = event.game.turn.turn_actions
    land_plays = turn_actions.select do |action|
      action.play_action? && action.card.has_rule?('Land')
    end
    land_plays.present?
  end

  def play_land event
    event.card.update_attributes :tapped => false

    event.player.board.add_card event.card
    event.game.turn.save_turn_action TurnAction.create(card: event.card, player: event.player, name: 'play')
  end
end
