class Hand < ActiveRecord::Base
  belongs_to :player
  has_many :cards, as: :card_holder

  def add_card(card)
    card.position = cards.length + 1
    cards << card
  end

  def hand_size
    cards.length
  end

  def has_card?(card)
    cards.include? card
  end
end
