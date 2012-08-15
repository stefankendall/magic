require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "Creating a new game cascades saves and create two players" do
    game = Game.new_game
    loaded_game = Game.find(game.id)
    assert_not_nil loaded_game.id
    assert_not_nil loaded_game.turn.id
    assert_equal 2, loaded_game.players.count
    assert_equal 2, Player.count
  end

  test "Creating a game creates player_state for each player" do
    game = Game.new_game
    assert_equal 2, game.players.count
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

  test "Creating a game creates a library for each player" do
    game = Game.new_game
    p0_library = game.players[0].library
    p1_library = game.players[1].library

    assert_not_nil p0_library
    assert_true p0_library.cards.any?

    assert_not_nil p1_library
    assert_true p1_library.cards.any?
  end

  test "New game starts in phase 1 in upkeep" do
    game = Game.new_game
    assert_equal "upkeep", game.turn.phase
    assert_equal 1, game.turn.count
    assert_equal Player.find(1), game.turn.player
  end
end
