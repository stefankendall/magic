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
end
