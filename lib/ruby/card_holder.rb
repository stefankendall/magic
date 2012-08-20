module CardHolder
  def has_card?(card)
    self.cards.include? card
  end
end