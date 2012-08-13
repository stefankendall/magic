require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "Creating a new game cascades saves and create two players" do
    game = Game.new_game
    assert_not_nil game.id
    assert_not_nil game.turn.id
    assert_equal [], game.player_states
    assert_equal 2, Player.count
  end

  test "Creating a game creates player_state for each player" do
    game = Game.new_game
    assert_equal 2, game.player_states.count
  end

  test "Creating a game creates an empty stack" do
    game = Game.new_game
    assert_equal [], game.stack.stack_frames
  end
end
