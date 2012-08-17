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
    applicable_rules = []
    rules.each do |rule|
      if rule.responds_to_event? event
        applicable_rules << rule
      end
    end

    applicable_rules.each do |rule|
      rule.respond_to_event event
    end
  end
end