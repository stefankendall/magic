class Event
  attr_accessor :card, :game, :player, :action, :targets

  def initialize(options)
    @card = options[:card]
    @game = options[:game]
    @player = options[:player]
    @action = options[:action]
    @targets = options[:targets]
  end

  def play_action?
    action == "play"
  end
  def tap_for_green?
    action == "tap for green"
  end
end