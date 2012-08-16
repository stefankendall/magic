# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Magic::Application.initialize!

require 'ruby/RuleNotifier'
require 'ruby/rules/PlayLand'
RuleNotifier.instance.register(PlayLand.new)
