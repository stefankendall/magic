ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
load "#{Rails.root}/db/seeds.rb"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def assert_no_date_fields_in_hash(hash)
    hash.each do |k, v|
      assert_not_equal 'created_at', k, hash
      assert_not_equal 'updated_at', k, hash
      if v.class == Hash
        assert_no_date_fields_in_hash(v)
      end
      if v.class == Array
        v.each do |element|
          if element.class == Hash
            assert_no_date_fields_in_hash(element)
          end
        end
      end
    end
  end

  def create_new_game
    old_controller = @controller
    @controller = GameController.new
    post :create
    body = ActiveSupport::JSON.decode @response.body
    game_id = body['id']

    @controller = old_controller
    game_id
  end

  def next_phase(game_id)
    old_controller = @controller
    @controller = PhaseController.new
    post :next, {:id => game_id}
    @controller = old_controller
  end

  def progress_phase(game_id, turn_symbol)
    Game.find(game_id).turn.send turn_symbol
  end

  def play_forest(game)
    old_controller = @controller
    @controller = CardController.new
    progress_phase game.id, :to_main_phase_1

    card = FactoryGirl.create(:card, archetype: 'Forest')

    game.players[0].hand.add_card card
    post :play, {id: game.id, card_id: card.id}
    game.reload

    @controller = old_controller
    card
  end

  def next_turn(game)
    game.turn.next_turn
    game.reload
    game.turn.next_turn
  end

  def play_creature(game, creature_name, *forests)
    old_controller = @controller
    @controller = CardController.new
    creature = FactoryGirl.create(:card, archetype: creature_name)
    game.players[0].hand.add_card creature

    forests.each do |forest|
      post :play, {id: game.id, card_id: forest.id, ability: 'tap for green'}
    end

    post :play, {id: game.id, card_id: creature.id, ability: 'play'}
    @controller = old_controller
  end
end
