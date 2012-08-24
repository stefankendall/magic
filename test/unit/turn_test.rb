require 'test_helper'

class TurnTest < ActiveSupport::TestCase
  test "A saved turn can be retrieved" do
    game = Game.new_game
    game.turn.update_attributes(count: 5)
    saved_turn = Turn.find(game.turn.id)
    assert_equal 5, saved_turn.count
  end

  test "next_phase moves to the next phase" do
    game = Game.new_game
    t = game.turn
    t.update_attributes(phase: Turn.PHASES[0], count: 1, player: game.players.first)
    t.next_phase
    t.reload
    assert_equal Turn.PHASES[1], t.phase
    assert_equal 1, t.count
  end

  test "next_phase moves to the next turn if you're on the end step and it's player 2's turn" do
    g = Game.new_game
    g.turn.next_turn
    g.turn.next_turn
    assert "untap", g.turn.phase
    assert_equal 2, g.turn.count
  end

  test "should increment turn during phase change if it's the second player's cleanup" do
    g = Game.new_game
    g.turn.update_attributes(phase: 'cleanup', count: 1, player: g.players.last)
    assert_true g.turn.should_increment_turn
  end

  test "should not increment turn during phase change if it's not the second player's cleanup" do
    game = Game.new_game
    game.turn.update_attributes phase: 'cleanup', count: 1, player: game.players.first
    assert_false game.turn.should_increment_turn
  end

  test "main_phase? responds with true for either main phase and false for other phases" do
    turn = Turn.new

    turn.to_main_phase_1
    assert_true turn.main_phase?

    turn.to_main_phase_2
    assert_true turn.main_phase?

    turn.to_upkeep
    assert_false turn.main_phase?
  end

  test "turn actions can be saved to a turn" do
    g = Game.new_game
    g.turn.save_turn_action TurnAction.create(name: 'play', card: FactoryGirl.create(:card), player: g.players[0])
    g.turn.reload
    assert_equal 1, g.turn.turn_actions.count
  end

  test "turn actions are cleared after a player's turn" do
    g = Game.new_game
    g.turn.save_turn_action TurnAction.create(name: 'play', card: FactoryGirl.create(:card), player: g.players[0])
    g.turn.next_turn
    assert_equal 0, g.turn.turn_actions.count
    assert_equal 0, TurnAction.count
  end

  test "turn.next_turn progresses to the next upkeep step" do
    g = Game.new_game
    g.turn.next_turn

    assert_equal g.players[1], g.turn.player
    assert_equal "untap", g.turn.phase

    g.turn.next_turn
    assert_equal g.players[0], g.turn.player
    assert_equal "untap", g.turn.phase
    assert_equal g.turn.count, 2
  end

  test "Progressing to the next turn changes the active player" do
    g = Game.new_game

    g.turn.next_turn
    assert_equal g.players[1], g.turn.player

    g.turn.next_turn
    assert_equal g.players[0], g.turn.player
  end

  test "Progressing to the combat phase from main phase 1 empties each player's mana pool" do
    game = Game.new_game
    game.turn.to_main_phase_1

    card = FactoryGirl.create(:card, archetype: 'Forest')
    game.players[0].hand.add_card card
    game.activate_ability card, 'play'
    game.activate_ability card, 'tap for green'

    mana_pool = game.players[0].mana_pool
    mana_pool.reload
    assert_equal 1, mana_pool.green

    game.turn.next_phase

    mana_pool.reload

    assert_true game.players[0].mana_pool.is_empty?
    assert_true game.players[1].mana_pool.is_empty?
  end

  test "Progressing to the declare attackers from combat phase does not empty each player's mana pool" do
    game = Game.new_game
    game.turn.to_main_phase_1
    card = FactoryGirl.create(:card, archetype: 'Forest')
    game.players[0].hand.add_card card
    game.activate_ability card, 'play'

    game.turn.to_combat_phase
    game.activate_ability card, 'tap for green'

    game.turn.next_phase

    mana_pool = game.players[0].mana_pool
    mana_pool.reload
    assert_false mana_pool.is_empty?
  end

  test "All creatures are unmarked as attacking when the phase moves out of resolve combat damage" do
    game = Game.new_game
    game.turn.to_combat_phase
    elvish_warrior = FactoryGirl.create(:card, archetype: 'Elvish Warrior')
    elvish_warrior.summoning_sick = false
    elvish_warrior.attacking = true
    game.players[0].board.add_card elvish_warrior

    game.turn.to_end_combat

    game.players[0].board.cards.each do |card|
      assert_false card.attacking
    end
  end

  test "Transitioning into the untap phase should untap all creatures" do
    game = Game.new_game
    game.turn.to_cleanup
    elvish_warrior = FactoryGirl.create(:card, archetype: 'Elvish Warrior', tapped: true)
    game.players[0].board.add_card elvish_warrior

    game.turn.next_phase

    assert_false elvish_warrior.tapped
  end
end
