FactoryGirl.define do
  factory :card do |f|
    archetype = "Forest"
    card_archetype = CardArchetype.find_or_create_by_name(archetype)
    f.card_archetype_id card_archetype.id
  end
end
