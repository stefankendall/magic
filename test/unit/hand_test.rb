require 'test_helper'

class HandTest < ActiveSupport::TestCase
  test "Inserting a card into a hand sets its position to last" do
    hand = Hand.create
    hand.add_card FactoryGirl.create(:card, :position => 1)
    hand.add_card FactoryGirl.create(:card, :position => 2)

    new_card = FactoryGirl.create(:card, :position => 43)
    hand.add_card new_card
    assert_equal 3, new_card.position
  end
end
