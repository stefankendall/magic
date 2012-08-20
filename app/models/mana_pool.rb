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
end
