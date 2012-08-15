require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "a saved player state can be retrieved with all associated models" do
    player = Player.create()
    player.create_graveyard
    player.create_hand
    player.create_library
    player.create_board

    saved_player = Player.find(player.id)
    assert_not_nil saved_player.graveyard
    assert_not_nil saved_player.hand
    assert_not_nil saved_player.library
    assert_not_nil saved_player.board
  end
end
