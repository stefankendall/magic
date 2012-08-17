class InvalidPlayError < StandardError
  def initialize(msg = "Invalid Play")
    super(msg)
  end
end