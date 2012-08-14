class Library < ActiveRecord::Base
  belongs_to :player_state
  has_many :cards

  def Library.create_default_library
    FactoryGirl.create(:elf_deck)
  end
end
