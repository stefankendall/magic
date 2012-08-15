require 'test_helper'

class TurnTest < ActiveSupport::TestCase
  test "A saved turn can be retrieved" do
    t = Turn.create(count: 5)
    saved_turn = Turn.find(t.id)
    assert_equal 5, saved_turn.count
  end

  test "next_phase moves to the next phase" do
    t = Turn.create(phase: 'upkeep', count: 1, player: Player.create(order: 1))
    t.next_phase
    t.reload
    assert_equal "draw", t.phase
    assert_equal 1, t.count
  end

  test "next_phase moves to the next turn if you're on the end step and it's player 2's turn" do
    p1 = Player.create(order: 1)
    p2 = Player.create(order: 2)

    t = Turn.create(phase: 'end step', count: 1, player: p2)
    t.next_phase
    t.reload
    assert "upkeep", t.phase
    assert_equal 2, t.count
  end

  test "should increment turn during phase change if it's the second player's end step" do
    p1 = Player.create(order: 1)
    p2 = Player.create(order: 2)
    t = Turn.create(phase: 'end step', count: 1, player: p2)
    assert_true t.should_increment_turn
  end

  test "should not increment turn during phase change if it's not the second player's end step" do
    p1 = Player.create(order: 1)
    p2 = Player.create(order: 2)
    t = Turn.create(phase: 'end step', count: 1, player: p1)
    assert_false t.should_increment_turn
  end
end
