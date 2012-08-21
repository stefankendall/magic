require "test_helper"

class ResolveCreatureTest < ActiveSupport::TestCase

  test "ResolveCreatureRule responds to 'resolve' creature" do
    resolve_creature_rule = ResolveCreature.new
    assert_true resolve_creature_rule.responds_to_event? Event.new :card => FactoryGirl.create(:card, archetype: 'Elvish Warrior'), :action => 'resolve'
  end

  test "ResolveCreatureRule doesn't respond to non creatures" do
    resolve_creature_rule = ResolveCreature.new
    assert_false resolve_creature_rule.responds_to_event? Event.new :card => FactoryGirl.create(:card, archetype: 'Forest'), :action => 'resolve'
  end

  test "ResolveCreatureRule doesn't respond to non 'resolve' events" do
    resolve_creature_rule = ResolveCreature.new
    assert_false resolve_creature_rule.responds_to_event? Event.new :card => FactoryGirl.create(:card, archetype: 'Elvish Warrior'), :action => 'play'
  end

  test "ResolveCreatureRule throws an error if the creature is not at the top of the stack" do
    game = Game.new_game
    elf = FactoryGirl.create(:card, archetype: 'Elvish Warrior')
    other_elf = FactoryGirl.create(:card, archetype: 'Elvish Warrior')
    game.stack.add_card elf, game.players[0]
    game.stack.add_card other_elf, game.players[0]

    resolve_creature_rule = ResolveCreature.new
    event = Event.new :card => elf, :game => game, :action => 'resolve'
    assert_raises InvalidPlayError do
      resolve_creature_rule.respond_to_event event
    end
  end

  test "ResolveCreatureRule doesn't respond if the creature isn't on the stack" do
    game = Game.new_game
    elf = FactoryGirl.create(:card, archetype: 'Elvish Warrior')

    resolve_creature_rule = ResolveCreature.new
    event = Event.new :card => elf, :game => game, :action => 'resolve'
    assert_raises InvalidPlayError do
      resolve_creature_rule.respond_to_event event
    end
  end

  test "ResolveCreatureRule removes the card from the top of the stack" do
    resolve_creature_rule = ResolveCreature.new
    game = Game.new_game
    elf = FactoryGirl.create(:card, archetype: 'Elvish Warrior')
    game.stack.add_card elf, game.players[0]
    event = Event.new :card => elf, :game => game, :action => 'resolve', :player => game.players[0]
    resolve_creature_rule.respond_to_event event

    assert_false game.stack.has_card? elf
  end

  test "ResolveCreatureRule moves the card to the board" do
    resolve_creature_rule = ResolveCreature.new
    game = Game.new_game
    elf = FactoryGirl.create(:card, archetype: 'Elvish Warrior')
    game.stack.add_card elf, game.players[0]
    event = Event.new :card => elf, :game => game, :action => 'resolve', :player => game.players[0]
    resolve_creature_rule.respond_to_event event

    assert_true game.players[0].board.has_card? elf
  end
end
