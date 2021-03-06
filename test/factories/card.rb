FactoryGirl.define do
  factory :card do |f|
    ignore do
      archetype "Forest"
    end
    f.card_archetype_id {
      CardArchetype.find_by_name(archetype).id
    }
  end
end
