require 'test_helper'

class StackFrameTest < ActiveSupport::TestCase
  test "A stack frame can be created with targets" do
     StackFrame.create(:card => FactoryGirl.create(:card), :targets => [], player: Player.create())
  end
end
