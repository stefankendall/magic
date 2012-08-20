class Board < ActiveRecord::Base
  belongs_to :player
  has_many :cards, as: :card_holder

  include CardHolder

  def add_card(card)
    card.position = cards.length + 1
    cards << card
  end
end
