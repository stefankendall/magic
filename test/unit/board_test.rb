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

  test "has_card can find cards" do
    board = Board.create
    elf = FactoryGirl.create :card, archetype: 'Elvish Warrior'
    assert_false board.has_card? elf

    board.add_card elf
    assert_true board.has_card? elf
  end
end
