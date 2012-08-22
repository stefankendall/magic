class Turn < ActiveRecord::Base
  has_one :player
  has_many :turn_actions, :dependent => :destroy
  belongs_to :game
  attr_accessible :count, :phase, :player

  attr_accessor :phases
  @@PHASES = ['untap', 'upkeep', 'draw', 'main phase 1', 'begin combat', 'declare attackers', 'declare blockers', 'combat damage', 'end combat', 'main phase 2', 'end step', 'cleanup']
  @@MANA_DRAIN_PHASES = ['untap', 'main phase 1', 'begin combat', 'main phase 2', 'end step']


  def Turn.PHASES
    @@PHASES
  end

  def next_phase
    current_index = @@PHASES.find_index phase
    new_phase_index = (current_index + 1) % @@PHASES.length

    if new_phase_index == 0
      self.turn_actions.delete_all
      self.player = game.players.select { |p| p != self.player }[0]
    end

    new_count = count
    if should_increment_turn
      new_count = count + 1
    end

    if should_drain_mana @@PHASES[new_phase_index]
      game.players.each do |player|
        player.mana_pool.empty
      end
    end

    self.assign_attributes :phase => @@PHASES[new_phase_index], :count => new_count
    self.save!

    if phase == 'end combat'
      RuleNotifier.instance.emit(Event.new(:action => "end combat"))
    end
  end

  def should_drain_mana(phase)
    @@MANA_DRAIN_PHASES.include? phase
  end

  def save_turn_action(turn_action)
    turn_actions << turn_action
  end

  def draw_step?
    self.phase == 'draw'
  end

  def main_phase_1?
    self.phase == "main phase 1"
  end

  def main_phase_2?
    self.phase == "main phase 2"
  end

  def main_phase?
    main_phase_1? or main_phase_2?
  end

  def declare_attackers?
    self.phase == "declare attackers"
  end

  def to_upkeep
    update_attributes :phase => 'upkeep'
  end

  def to_main_phase_1
    update_attributes :phase => 'main phase 1'
  end

  def to_combat_phase
    update_attributes :phase => 'begin combat'
  end

  def to_end_combat
    update_attributes :phase => 'end combat'
  end

  def to_declare_attackers
    update_attributes :phase => 'declare attackers'
  end

  def to_main_phase_2
    update_attributes :phase => 'main phase 2'
  end

  def to_end_step
    update_attributes :phase => 'end step'
  end

  def should_increment_turn
    player.order == 2 && phase == 'cleanup'
  end

  def next_turn
    begin
      self.next_phase
    end while self.phase != 'untap'
  end
end