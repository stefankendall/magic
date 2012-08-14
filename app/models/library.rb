class Library < ActiveRecord::Base
  belongs_to :player_state
  has_many :cards

  def Library.create_default_library
    library = Library.new
    library.cards << FactoryGirl.create(:card)
    library
  end
end
