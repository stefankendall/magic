require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "Creating a new game cascades saves and create two players" do
    game = Game.new_game
    loaded_game = Game.find(game.id)
    assert_not_nil loaded_game.id
    assert_not_nil loaded_game.turn.id
    assert_equal 2, loaded_game.player_states.count
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

  test "Serializing a game to json excludes created_at and updated_at" do
    game = Game.new_game
    json = ActiveSupport::JSON.decode(game.to_json)

    assert_nil json['created_at']
    assert_nil json['updated_at']
  end
end
