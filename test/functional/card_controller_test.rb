require 'test_helper'

class CardControllerTest < ActionController::TestCase
  test "I can play a land from my hand" do
    game_id = create_new_game
    next_phase game_id
    game = Game.find(game_id)
    card = FactoryGirl.create(:card, archetype: 'Forest')
    game.players[0].hand.add_card card

    post :play, {id: game_id, card_id: card.id}

    assert_false game.players[0].hand.has_card? card
    assert_equal 1, game.board.cards.count
  end
end
