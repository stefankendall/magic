class Rule
  def responds_to_event?(event)
    raise 'must be overridden'
  end

  def respond_to_event(event)
    raise 'must be overridden'
  end
end