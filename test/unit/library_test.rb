require 'test_helper'

class LibraryTest < ActiveSupport::TestCase
  test "Library.create_default_library builds a library" do
    library = Library.create_default_library
    assert_not_nil library
  end

  test "Create default library puts cards in the library" do
    library = Library.create_default_library
    assert_true library.cards.any?
    assert_equal "Forest", library.cards[0].card_archetype.name
  end

  test "Creating a default library gives you 40 cards: 16 lands and 24 creatures" do
    library = Library.create_default_library
    assert_equal 40, library.cards.count
  end

  test "top_card should return the card on top of the library" do
    library = Library.create
    card1 = FactoryGirl.create(:card, :position => 2)
    card2 = FactoryGirl.create(:card, :position => 1)
    library.cards << card2
    library.cards << card1

    assert_equal card2, library.top_card
  end
end
