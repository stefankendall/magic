require 'test_helper'

class LibraryTest < ActiveSupport::TestCase
  test "Library.create_default_library builds a library" do
    library = Library.create_default_library
    assert_not_nil library
  end

  test "Create default library puts cards in the library" do
    library = Library.create_default_library
    assert_true library.cards.any?
    assert_equal "Birds of Paradise", library.cards[0].card_archetype.name
  end
end
