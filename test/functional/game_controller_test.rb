require 'test_helper'

class GameControllerTest < ActionController::TestCase
  test "games can be retrieved" do
    get :show, {id:"12"}
    assert_response :success
  end

  test "games can be created" do
    post :create
    assert_response :success
    body = ActiveSupport::JSON.decode @response.body
    assert_not_nil(body['player_states'])
    assert_not_nil(body['turn'])
    #assert_not_nil(body['stack'])
    #assert_not_nil(body['combat'])
  end
end
