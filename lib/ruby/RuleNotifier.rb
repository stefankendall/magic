require 'singleton'
class RuleNotifier
  include Singleton

  attr_reader :rules

  def initialize
    @rules = []
  end

  def register(rule)
    rules << rule
  end

  def emit(event)

  end
end