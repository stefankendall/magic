module CardHolder
  def has_card?(card)
    self.cards.include? card
  end

  def is_empty?
    not self.cards.any?
  end
end