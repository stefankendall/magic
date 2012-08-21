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

  def next_turn(game)
    game.turn.next_turn
    game.reload
    game.turn.next_turn
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

    post :play, {id: game.id, card_id: card.id, ability: 'tap for green'}
    card.reload

    assert_equal true, card.tapped
  end

  test "I can play an Elvish Warrior if I have the right amount of mana" do
    game = Game.find create_new_game
    forest1 = play_forest game
    next_turn game
    forest2 = play_forest game

    elvish_warrior = FactoryGirl.create(:card, archetype: "Elvish Warrior")
    game.players[0].hand.add_card elvish_warrior

    post :play, {id: game.id, card_id: forest1.id, ability: 'tap for green'}
    post :play, {id: game.id, card_id: forest2.id, ability: 'tap for green'}
    post :play, {id: game.id, card_id: elvish_warrior.id, ability: 'play'}
    game.reload

    assert_false game.stack.is_empty?
    assert_true game.stack.has_card? elvish_warrior
    assert_true game.players[0].mana_pool.is_empty?
  end

end
