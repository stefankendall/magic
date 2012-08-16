require 'test_helper'

class TurnTest < ActiveSupport::TestCase
  test "A saved turn can be retrieved" do
    game = Game.new_game
    game.turn.update_attributes(count: 5)
    saved_turn = Turn.find(game.turn.id)
    assert_equal 5, saved_turn.count
  end

  test "next_phase moves to the next phase" do
    game = Game.new_game
    t = game.turn
    t.update_attributes(phase: Turn.PHASES[0], count: 1, player: game.players.first)
    t.next_phase
    t.reload
    assert_equal Turn.PHASES[1], t.phase
    assert_equal 1, t.count
  end

  test "next_phase moves to the next turn if you're on the end step and it's player 2's turn" do
    g = Game.new_game
    g.turn.update_attributes(phase: 'end step', count: 1, player: g.players.last)

    turn = g.turn
    turn.next_phase
    turn.reload
    assert "upkeep", turn.phase
    assert_equal 2, turn.count
  end

  test "should increment turn during phase change if it's the second player's end step" do
    g = Game.new_game
    g.turn.update_attributes(phase: 'end step', count: 1, player: g.players.last)
    assert_true g.turn.should_increment_turn
  end

  test "should not increment turn during phase change if it's not the second player's end step" do
    game = Game.new_game
    game.turn.update_attributes phase: 'end step', count: 1, player: game.players.first
    assert_false game.turn.should_increment_turn
  end
end
