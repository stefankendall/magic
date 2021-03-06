require 'test_helper'

class PhaseControllerTest < ActionController::TestCase
  test "calling next phase for a given game id increments that game's phase" do
    game_id = create_new_game
    post :next, {:id => game_id}

    body = ActiveSupport::JSON.decode @response.body
    turn = body['turn']
    assert_equal 1, turn['count']
    assert_equal "main phase 1", turn['phase']
  end
end
