require 'test_helper'

class GameControllerTest < ActionController::TestCase
  test "games can be retrieved" do
    post :create
    body = ActiveSupport::JSON.decode @response.body
    game_id = body['id']

    get :show, {id: game_id}
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

  test "created_at and updated_at are not present in the GET game response at all" do
    post :create
    body = ActiveSupport::JSON.decode @response.body
    game_id = body['id']
    get :show, {id: game_id}
    body = ActiveSupport::JSON.decode @response.body
    assert_no_date_fields_in_hash body
  end
end
