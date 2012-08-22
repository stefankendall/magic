require "test_helper"

class DeclareAttackersTest < ActiveSupport::TestCase
  test "Declare attackers rule responds to creatures attacking in declare attackers phase" do
    declare_attackers_rule = DeclareAttackers.new

    game = Game.new_game
    elvish_warrior = FactoryGirl.create(:card, archetype: 'Elvish Warrior')
    game.players[0].board.add_card elvish_warrior
    game.turn.to_declare_attackers

    declare_attacker_event = Event.new(:card => elvish_warrior, :game => game, :player => game.players[0], :action => 'declare attackers')
    assert_true declare_attackers_rule.responds_to_event? declare_attacker_event
  end

  test "A tapped creature cannot attack" do
    game = Game.new_game
    elvish_warrior = FactoryGirl.create(:card, archetype: 'Elvish Warrior')
    elvish_warrior.tapped = true
    game.players[0].board.add_card elvish_warrior
    game.turn.to_declare_attackers

    declare_attacker_event = Event.new(:card => elvish_warrior, :game => game, :player => game.players[0], :action => 'declare attackers')
    declare_attackers_rule = DeclareAttackers.new

    assert_raises InvalidPlayError do
      declare_attackers_rule.respond_to_event declare_attacker_event
    end
  end

  test "Another player's creature cannot attack on my turn" do
    game = Game.new_game
    elvish_warrior = FactoryGirl.create(:card, archetype: 'Elvish Warrior')
    game.players[1].board.add_card elvish_warrior
    game.turn.to_declare_attackers

    declare_attacker_event = Event.new(:card => elvish_warrior, :game => game, :player => game.players[0], :action => 'declare attackers')
    declare_attackers_rule = DeclareAttackers.new

    assert_raises InvalidPlayError do
      declare_attackers_rule.respond_to_event declare_attacker_event
    end
  end

  test "A summoning sick creature cannot attack" do
    game = Game.new_game
    elvish_warrior = FactoryGirl.create(:card, archetype: 'Elvish Warrior')
    elvish_warrior.summoning_sick = true
    game.players[0].board.add_card elvish_warrior
    game.turn.to_declare_attackers

    declare_attacker_event = Event.new(:card => elvish_warrior, :game => game, :player => game.players[0], :action => 'declare attackers')
    declare_attackers_rule = DeclareAttackers.new

    assert_raises InvalidPlayError do
      declare_attackers_rule.respond_to_event declare_attacker_event
    end
  end

  test "A non-summoning sick creature I can control can attack during the declare attackers phase" do
    game = Game.new_game
    elvish_warrior = FactoryGirl.create(:card, archetype: 'Elvish Warrior')
    game.players[0].board.add_card elvish_warrior
    game.turn.to_declare_attackers

    declare_attacker_event = Event.new(:card => elvish_warrior, :game => game, :player => game.players[0], :action => 'declare attackers')
    declare_attackers_rule = DeclareAttackers.new

    declare_attackers_rule.respond_to_event declare_attacker_event
    assert_true elvish_warrior.attacking
  end
end