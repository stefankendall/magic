require 'test_helper'

class CardControllerTest < ActionController::TestCase
  def play_forest(game)
    progress_phase game.id, :to_main_phase_1

    card = FactoryGirl.create(:card, archetype: 'Forest')

    game.players[0].hand.add_card card
    post :play, {id: game.id, card_id: card.id}
    game.reload
    card
  end

  test "I can play a land from my hand" do
    game = Game.find create_new_game
    card = play_forest(game)
    game.reload

    assert_false game.players[0].hand.has_card? card
    assert_equal 1, game.players[0].board.cards.count
  end

  test "I can tap a forest for green" do
    game = Game.find create_new_game
    card = play_forest(game)
    game.reload

    post :play, {id: game.id, card_id: card.id, ability: 'tap for green'}
    card.reload

    assert_equal true, card.tapped
  end
end
