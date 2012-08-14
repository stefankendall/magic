require 'test_helper'

class PlayerStateTest < ActiveSupport::TestCase
  test "a saved player state can be retrieved with all associated models" do
    player_state = PlayerState.create()
    player_state.create_player
    player_state.create_graveyard
    player_state.create_hand
    player_state.create_library
    player_state.create_board

    saved_player_state = PlayerState.find(player_state.id)
    assert_not_nil saved_player_state.player
    assert_not_nil saved_player_state.graveyard
    assert_not_nil saved_player_state.hand
    assert_not_nil saved_player_state.library
    assert_not_nil saved_player_state.board
  end
end
