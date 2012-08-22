require 'test_helper'

class StackTest < ActiveSupport::TestCase
  test "is_empty? returns true if there are no stack frames" do
    stack = Stack.create
    assert_true stack.is_empty?
  end

  test "is_empty? returns false if there are stack frames" do
    stack = Stack.create
    stack.stack_frames << StackFrame.create
    assert_false stack.is_empty?
  end

  test "add_card puts a card at the end of the stack" do
    stack = Stack.create
    elf = FactoryGirl.create :card, archetype: 'Elvish Warrior'
    other_elf = FactoryGirl.create :card, archetype: 'Elvish Warrior'
    stack.add_card elf, nil
    stack.add_card other_elf, nil

    assert_equal elf, stack.stack_frames[0].card
    assert_equal other_elf, stack.stack_frames.last.card
  end

  test "top_card returns the card at the top of the stack" do
    stack = Stack.create

    elf = FactoryGirl.create :card, archetype: 'Elvish Warrior'
    stack.add_card elf, nil
    assert_equal elf, stack.top_card

    other_elf = FactoryGirl.create :card, archetype: 'Elvish Warrior'
    stack.add_card other_elf, nil
    assert_equal other_elf, stack.top_card
  end

  test "has_card? detects if a card is in the stack" do
    stack = Stack.create

    elf = FactoryGirl.create :card, archetype: 'Elvish Warrior'
    stack.add_card elf, nil
    assert_true stack.has_card? elf

    other_elf = FactoryGirl.create :card, archetype: 'Elvish Warrior'
    assert_false stack.has_card? other_elf
  end

  test "remove_top_card deletes the top stack frame" do
    stack = Stack.create

    elf = FactoryGirl.create :card, archetype: 'Elvish Warrior'
    stack.add_card elf, nil

    stack.remove_top

    assert_false stack.has_card? elf
  end

  test "get_casting_player returns the player that cast a spell on the stack" do
    stack = Stack.create
    player = Player.create
    elf = FactoryGirl.create :card, archetype: 'Elvish Warrior'
    stack.add_card elf, player

    assert_equal player, stack.get_casting_player(elf)
  end
end
