FactoryGirl.define do
  factory :card do |f|
    archetype = "Forest"

    f.card_archetype_id {
      CardArchetype.find_or_create_by_name(archetype).id
    }
  end
end
