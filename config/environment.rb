# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Magic::Application.initialize!

require 'ruby/rule_notifier'
require 'ruby/rules/rule_implementation'
require 'ruby/rules/play_land'
RuleNotifier.instance.register(PlayLand.new)
