require "test_helper"

class TapForGreenTest < ActiveSupport::TestCase
  test "Tapping a Forest not on your board raises an InvalidPlayError" do
    game = Game.new_game
    tap_for_green_rule = TapForGreen.new
    game.turn.to_main_phase_1
    assert_raises InvalidPlayError do
      card = FactoryGirl.create(:card, archetype: 'Forest')
      game.players[1].hand.add_card card
      tap_for_green_rule.respond_to_event Event.new(game: game, action: 'tap for green', card: card, player: game.players[0])
    end
  end

  test "Tapping a Forest on your board taps the forest and adds 1 green to your mana pool" do
    game = Game.new_game
    tap_for_green_rule = TapForGreen.new
    game.turn.to_main_phase_1

    card = FactoryGirl.create(:card, archetype: 'Forest')
    game.players[0].hand.add_card card
    game.play_card card, 'play'
    tap_for_green_rule.respond_to_event Event.new(game: game, action: 'tap for green', card: card, player: game.players[0])

    assert_true card.tapped
    assert_equal 1, game.players[0].mana_pool.green
  end

end