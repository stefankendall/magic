class Library < ActiveRecord::Base
  belongs_to :player
  has_many :cards

  def Library.create_default_library
    FactoryGirl.create(:elf_deck)
  end
end
