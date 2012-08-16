class Library < ActiveRecord::Base
  belongs_to :player
  has_many :cards, as: :card_holder, :order => :position

  def Library.create_default_library
    FactoryGirl.create(:elf_deck)
  end

  def top_card
    cards.first
  end

  def card_count
     cards.length
  end
end
