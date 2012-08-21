# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Magic::Application.initialize!

require 'ruby/rule_notifier'
require 'ruby/rules/rule_implementation'
require 'ruby/rules/play_land'
require 'ruby/rules/tap_for_green'
require 'ruby/rules/play_creature'
RuleNotifier.instance.register(PlayLand.new)
RuleNotifier.instance.register(TapForGreen.new)
RuleNotifier.instance.register(PlayCreature.new)
