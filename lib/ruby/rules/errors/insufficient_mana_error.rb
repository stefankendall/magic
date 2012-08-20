class InsufficientManaError < StandardError
  def initialize(msg = "Insufficient Mana")
    super(msg)
  end
end