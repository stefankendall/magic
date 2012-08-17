require "test_helper"

class PlayLandTest < ActiveSupport::TestCase
  test "The PlayLand rule responds to playing a land during all phases" do
    transitions = [:to_main_phase_1, :to_main_phase_2, :to_upkeep]
    transitions.each do |transition|
      game = Game.new_game
      play_land_rule = PlayLand.new
      game.turn.send transition
      event = Event.new(game: game, action: 'play', card: FactoryGirl.create(:card, archetype: 'Forest'))
      assert_true play_land_rule.responds_to_event? event
    end
  end

  test "Playing a land in upkeep raises an InvalidPlayError" do
    game = Game.new_game
    play_land_rule = PlayLand.new
    card = FactoryGirl.create(:card, archetype: "Forest")
    game.players[0].hand.add_card card
    game.turn.to_upkeep

    assert_raises InvalidPlayError do
      play_land_rule.respond_to_event Event.new(game: game, action: 'play', card: card, player: game.players[0])
    end
  end

  test "Playing a land not in your hand raises and InvalidPlayError" do
    game = Game.new_game
    play_land_rule = PlayLand.new
    game.turn.to_main_phase_1
    assert_raises InvalidPlayError do
      card = FactoryGirl.create(:card, archetype: 'Forest')
      game.players[1].hand.add_card card
      play_land_rule.respond_to_event Event.new(game: game, action: 'play', card: card, player: game.players[0])
    end
  end

  test "Playing a land moves the land from the hand to the board" do
    game = Game.new_game
    play_land_rule = PlayLand.new
    card = FactoryGirl.create(:card, archetype: "Forest")
    game.players[0].hand.add_card card
    game.turn.to_main_phase_1

    play_land_rule.respond_to_event Event.new(game: game, action: 'play', card: card, player: game.players[0])

    assert_true game.players[0].board.cards.any?
  end

  test "Playing a land when not your turn results in an InvalidPlayError" do
    game = Game.new_game
    play_land_rule = PlayLand.new
    card = FactoryGirl.create(:card, archetype: "Forest")
    game.players[1].hand.add_card card
    game.turn.to_main_phase_1

    assert_raises InvalidPlayError do
      play_land_rule.respond_to_event Event.new(game: game, action: 'play', card: card, player: game.players[1])
    end
  end

  test "Playing a second land in a turn results in an InvalidPlayError" do
    game = Game.new_game
    play_land_rule = PlayLand.new
    land1 = FactoryGirl.create(:card, archetype: "Forest")
    land2 = FactoryGirl.create(:card, archetype: "Forest")
    game.players[0].hand.add_card land1
    game.players[0].hand.add_card land2
    game.turn.to_main_phase_1

    play_land_rule.respond_to_event Event.new(game: game, action: 'play', card: land1, player: game.players[0])
    assert_raises InvalidPlayError do
      play_land_rule.respond_to_event Event.new(game: game, action: 'play', card: land2, player: game.players[0])
    end
  end

  test "Each turn the active player may play a land" do
    game = Game.new_game
    play_land_rule = PlayLand.new
    land1 = FactoryGirl.create(:card, archetype: "Forest")
    land2 = FactoryGirl.create(:card, archetype: "Forest")
    land3 = FactoryGirl.create(:card, archetype: "Forest")
    game.players[0].hand.add_card land1
    game.players[1].hand.add_card land2
    game.players[0].hand.add_card land3

    game.turn.to_main_phase_1
    play_land_rule.respond_to_event Event.new(game: game, action: 'play', card: land1, player: game.players[0])

    game.turn.next_turn
    game.turn.to_main_phase_1
    play_land_rule.respond_to_event Event.new(game: game, action: 'play', card: land2, player: game.players[1])

    game.turn.next_turn
    game.turn.to_main_phase_1
    play_land_rule.respond_to_event Event.new(game: game, action: 'play', card: land3, player: game.players[0])
  end
end