require "test_helper"

class PlayCreatureTest < ActiveSupport::TestCase
  test "PlayCreature rule does not respond to lands" do
    play_creature_rule = PlayCreature.new
    assert_false play_creature_rule.responds_to_event? Event.new(:card => FactoryGirl.create(:card, archetype: 'Forest'))
  end

  test "PlayCreature responds to Elvish Warrior" do
    play_creature_rule = PlayCreature.new
    assert_true play_creature_rule.responds_to_event? Event.new(:card => FactoryGirl.create(:card, archetype: 'Elvish Warrior'))
  end

  test "Playing a creature without sufficient mana throws an error" do
    game = Game.new_game
    game.turn.to_main_phase_1
    play_creature_rule = PlayCreature.new
    card = FactoryGirl.create(:card, archetype: 'Elvish Warrior')
    game.players[0].hand.add_card card

    assert_raises InsufficientManaError do
      play_creature_rule.respond_to_event Event.new(game: game, action: 'play', card: card, player: game.players[0])
    end
  end

  test "Playing a creature with sufficient mana and an empty stack puts it on the stack" do
    game = Game.new_game
    game.turn.to_main_phase_1
    play_creature_rule = PlayCreature.new
    card = FactoryGirl.create(:card, archetype: 'Elvish Warrior')
    game.players[0].hand.add_card card
    game.players[0].mana_pool.add_green 2

    play_creature_rule.respond_to_event Event.new(game: game, action: 'play', card: card, player: game.players[0])
    assert_false game.stack.is_empty?
    assert_true game.stack.has_card? card
  end
end