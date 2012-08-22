require 'test_helper'

class StackControllerTest < ActionController::TestCase
  test "I can resolve the stack and play an Elvish warrior" do
    game = Game.find create_new_game
    forest1 = play_forest game
    next_turn game
    forest2 = play_forest game
    play_creature(game, "Elvish Warrior", forest1, forest2)

    get :resolve, {id: game.id}
    game.reload

    assert_true game.stack.is_empty?
    assert_false game.players[0].board.is_empty?
  end
end
