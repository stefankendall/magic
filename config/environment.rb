# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Magic::Application.initialize!

require 'ruby/rule_notifier'
require 'ruby/rules/rule_implementation'

require 'ruby/rules/play_land'
RuleNotifier.instance.register(PlayLand.new)

require 'ruby/rules/tap_for_green'
RuleNotifier.instance.register(TapForGreen.new)

require 'ruby/rules/play_creature'
RuleNotifier.instance.register(PlayCreature.new)

require 'ruby/rules/resolve_creature'
RuleNotifier.instance.register(ResolveCreature.new)
