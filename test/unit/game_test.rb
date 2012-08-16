require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "Creating a new game cascades saves and create two players" do
    game = Game.new_game
    loaded_game = Game.find(game.id)
    assert_not_nil loaded_game.id
    assert_not_nil loaded_game.turn.id
    assert_equal 2, loaded_game.players.count
    assert_equal 2, Player.count

    assert_not_nil Player.find_by_order(1)
    assert_not_nil Player.find_by_order(2)

    Player.all.each do |player|
      assert_equal 20, player.life_total
    end
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

  test "should throw an error if the phase is being incremented with a non-empty stack" do
    game = Game.new_game
    game.stack.stack_frames << StackFrame.create()

    assert_raises("error") do
      game.next_phase
    end
  end

  test "should draw a card and end in main phase 1 if I increment the phase from upkeep" do
    game = Game.new_game
    old_hand_count = game.players.first.hand.hand_size
    old_library_count = game.players.first.library.card_count
    game.next_phase
    game.reload

    assert_true game.turn.main_phase_1?
    assert_equal old_hand_count + 1, game.players.first.hand.hand_size
    assert_equal old_library_count - 1, game.players.first.library.card_count
  end
end
