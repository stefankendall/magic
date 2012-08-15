class Graveyard < ActiveRecord::Base
  belongs_to :player
  has_many :cards, as: :card_holder
end
