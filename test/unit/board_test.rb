require 'test_helper'
require 'factory_girl'

class BoardTest < ActiveSupport::TestCase
  test "a board saved with cards can retrieve those cards" do
    board = Board.create
    board.cards << FactoryGirl.create(:card)
    board.save

    saved_board = Board.find(board.id)
    assert_equal 1, saved_board.cards.count
  end
end
