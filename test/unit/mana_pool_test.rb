require 'test_helper'
require 'mana_pool'

class ManaPoolTest < ActiveSupport::TestCase
  test "mana_pool.create creates a valid empty mana pool" do
    pool = ManaPool.create
    assert_true pool.is_empty?
  end

  test "mana_pool.add_green adds an amount of mana to the mana pool" do
    pool = ManaPool.create
    pool.add_green
    assert_equal 1, pool.green

    pool.add_green 5
    assert_equal 6, pool.green
  end

  test "pay_for returns true when I can afford Elvish Warrior" do
    pool = ManaPool.create
    pool.add_green(1)
    assert_raises InsufficientManaError do
      pool.pay_for FactoryGirl.create :card, :archetype => 'Elvish Warrior'
    end
    assert_false pool.is_empty?
  end

  test "pay_for returns false when I cannot afford Elvish Warrior" do
    pool = ManaPool.create
    pool.add_green(2)
    pool.pay_for FactoryGirl.create :card, :archetype => 'Elvish Warrior'
    assert_true pool.is_empty?
  end
end
