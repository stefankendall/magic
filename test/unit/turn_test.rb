require 'test_helper'

class TurnTest < ActiveSupport::TestCase
  test "A saved turn can be retrieved" do
    t = Turn.create(count:5)
    saved_turn = Turn.find(t.id)
    assert_equal 5, saved_turn.count
  end
end
