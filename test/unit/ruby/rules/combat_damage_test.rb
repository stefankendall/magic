require "test_helper"

class CombatDamageTest < ActiveSupport::TestCase
  test "Combat damage deals attacking damage to enemy player" do
    game = Game.new_game
    elvish_warrior1 = FactoryGirl.create(:card, archetype: 'Elvish Warrior', attacking: true)
    elvish_warrior2 = FactoryGirl.create(:card, archetype: 'Elvish Warrior', attacking: true)

    game.players[0].board.add_card elvish_warrior1
    game.players[0].board.add_card elvish_warrior2

    combat_damage_event = Event.new(:game => game, :action => 'combat damage')
    combat_damage_rule = CombatDamage.new

    combat_damage_rule.respond_to_event combat_damage_event
    assert_equal 20 - 2 * 2, game.players[1].life_total
  end
end