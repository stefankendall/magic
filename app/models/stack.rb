class Stack < ActiveRecord::Base
  belongs_to :game
  has_many :stack_frames

  attr_accessible :stack_frames

  def add_card(card, player, targets = [])
    stack_frames << StackFrame.create(card: card, targets: targets, player: player)
  end

  def has_card?(card)
    stack_frames.any? do |stack_frame|
      stack_frame.card == card
    end
  end

  def is_empty?
    !stack_frames.any?
  end

  def top_card
    unless self.is_empty?
      stack_frames.last.card
    end
  end

  def remove_top
    stack_frames.delete(stack_frames.last)
  end

  def get_casting_player(card)
    stack_frame = stack_frames.find do |stack_frame|
      stack_frame.card == card
    end
    stack_frame.player
  end
end
