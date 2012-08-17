require 'test_helper'

class CardControllerTest < ActionController::TestCase
  test "I can play a land from my hand" do
    game_id = create_new_game
    progress_phase game_id, :to_main_phase_1
    game = Game.find(game_id)
    card = FactoryGirl.create(:card, archetype: 'Forest')
    game.players[0].hand.add_card card

    post :play, {id: game_id, card_id: card.id}

    game.reload

    assert_false game.players[0].hand.has_card? card
    assert_equal 1, game.players[0].board.cards.count
  end
end
