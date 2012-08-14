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
end
