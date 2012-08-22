require "test_helper"

class EndCombatTest < ActiveSupport::TestCase
  test "Ending combat unmarks all attacking creatures as attacking" do
    game = Game.new_game

    game.turn.player.board.add_card FactoryGirl.create(:card, :archetype => 'Elvish Warrior')

    end_combat_rule = EndCombat.new
    end_combat_rule.respond_to_event Event.new(:action => "end combat", :game => game)

    game.turn.player.board.cards.each do |card|
      assert_false card.attacking
    end
  end
end