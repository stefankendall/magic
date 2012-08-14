FactoryGirl.define do
  factory :library do |f|
    factory :elf_deck do |e|
      after(:build) do |library|
        library.cards << FactoryGirl.create_list(:card, 16, :archetype => 'Forest')
        library.cards << FactoryGirl.create_list(:card, 24, archetype: "Elvish Warrior")
      end
    end
  end
end
