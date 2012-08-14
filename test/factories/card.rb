FactoryGirl.define do
  factory :card do |f|
    f.card_archetype_id {
      CardArchetype.find_or_create_by_name("Birds of Paradise").id
    }
  end
end
