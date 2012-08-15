require 'test_helper'

class CardTest < ActiveSupport::TestCase
  test "Card cannot be created without an archetype" do
    c = Card.new
    assert_false c.save()
  end

  test "Card can be created with an archetype" do
    card_archetype = CardArchetype.create(name: "Birds of Paradise")
    c = Card.create(:card_archetype => card_archetype)
    assert_true c.save()
  end

  test "A card can only belong to one holder at a time, but not two" do
    card = FactoryGirl.create(:card)
    library = Library.create()
    hand = Hand.create()
    library.cards << card
    library.save()
    hand.cards << card
    hand.save()

    assert_equal 1, hand.cards.count
    assert_equal 0, library.cards.count
 end

end
