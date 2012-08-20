class ManaPool < ActiveRecord::Base
  belongs_to :player
  attr_accessible :green, :blue, :red, :white, :black, :colorless

  def add_green(amount = 1)
    update_attributes :green => green + amount
  end

  def is_empty?
    0 == (green + blue + red + white + black + colorless)
  end

  def empty
    update_attributes :green => 0, :blue => 0, :red => 0, :white => 0, :black => 0, :colorless => 0
  end

  def pay_for(card)
    current_mana = clone_attributes()
    price = {
        'green' => card.card_archetype.greenCost,
        'blue' => card.card_archetype.blueCost,
        'red' => card.card_archetype.redCost,
        'black' => card.card_archetype.blackCost,
        'white' => card.card_archetype.whiteCost,
        'colorless' => card.card_archetype.colorlessCost,
    }

    pay_for_specific_colors(current_mana, price)
    pay_for_colorless(current_mana, price)
  end

  def pay_for_colorless(current_mana, price)
    remaining_colorless_price = price['colorless']
    price.invert.keys do |color|
      if remaining_colorless_price > current_mana[color]
        remaining_colorless_price -= current_mana[color]
        current_mana[color] = 0
      else
        current_mana[color] -= remaining_colorless_price
        remaining_colorless_price = 0
      end
    end

    if remaining_colorless_price > 0
      raise InsufficientManaError.new
    else
      update_attributes :green => current_mana['green'],
                        :blue => current_mana['blue'],
                        :red => current_mana['red'],
                        :black => current_mana['black'],
                        :white => current_mana['white'],
                        :colorless => current_mana['colorless']
    end
  end

  def pay_for_specific_colors(current_mana, price)
    specific_colors = %w(green blue red black white)
    specific_colors.each do |color|
      current_mana[color] -= price[color]
    end

    if specific_colors.any? { |color| current_mana[color] < 0 }
      raise InsufficientManaError.new
    end
  end
end