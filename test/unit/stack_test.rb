require 'test_helper'

class StackTest < ActiveSupport::TestCase
  test "is_empty? returns true if there are no stack frames" do
    stack = Stack.create()
    assert_true stack.is_empty?
  end

  test "is_empty? returns false if there are stack frames" do
    stack = Stack.create()
    stack.stack_frames << StackFrame.create()
    assert_false stack.is_empty?
  end
end
