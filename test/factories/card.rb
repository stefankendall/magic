FactoryGirl.define do
  factory :card do |f|
    card_archetype = CardArchetype.find_or_create_by_name("Birds of Paradise")
    f.card_archetype_id card_archetype.id
  end
end
