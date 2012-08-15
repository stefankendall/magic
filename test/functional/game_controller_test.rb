require 'test_helper'

class GameControllerTest < ActionController::TestCase
  test "games can be retrieved" do
    post :create
    body = ActiveSupport::JSON.decode @response.body
    game_id = body['id']

    get :show, {id:game_id}
    assert_response :success
    body = ActiveSupport::JSON.decode @response.body
    assert_not_nil body['id']
    assert_not_nil body['turn']
    assert_not_nil body['stack']
  end

  test "games can be created" do
    post :create
    assert_response :success
    body = ActiveSupport::JSON.decode @response.body
    assert_not_nil(body['players'])
    assert_not_nil(body['turn'])
    assert_not_nil(body['stack'])
    #assert_not_nil(body['combat'])
  end
end
