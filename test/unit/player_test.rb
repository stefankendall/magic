require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "a saved player state can be retrieved with all associated models" do
    player = Player.create :mana_pool => ManaPool.create
    player.create_graveyard
    player.create_hand
    player.create_library
    player.create_board

    player.reload
    assert_not_nil player.graveyard
    assert_not_nil player.hand
    assert_not_nil player.library
    assert_not_nil player.board
    assert_not_nil player.mana_pool
  end
end
