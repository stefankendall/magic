FactoryGirl.define do
  factory :card do |f|
    ignore do
      archetype "Forest"
    end
    f.card_archetype_id {
      CardArchetype.find_or_create_by_name(archetype).id
    }
    #initialize_with {
    #  Card.new(archetype)
    #}
  end
end
