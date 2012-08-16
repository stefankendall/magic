require "test_helper"
require "ruby/RuleNotifier"

class RuleNotifierTest < ActiveSupport::TestCase
  test "The rule notifier instance is populated with rules before the server starts" do
    assert_not_equal 0, RuleNotifier.instance.rules.length
  end
end