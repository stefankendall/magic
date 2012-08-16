class Turn < ActiveRecord::Base
  has_one :player
  belongs_to :game
  attr_accessible :count, :phase, :player

  validate :stack_must_be_empty

  @@PHASES = ['untap', 'upkeep', 'draw', 'main phase 1', 'main phase 2', 'end step']

  def next_phase
    current_index = @@PHASES.find_index phase
    current_index = (current_index + 1) % @@PHASES.length

    new_count = count
    if should_increment_turn
      new_count = count + 1
    end

    self.assign_attributes :phase => @@PHASES[current_index], :count => new_count
    self.save!
  end

  def should_increment_turn
    player.order == 2 && phase == 'end step'
  end


  def stack_must_be_empty
    unless self.game.stack.is_empty?
      errors[:stack] << 'Stack must be empty to increment the phase'
    end
  end
end