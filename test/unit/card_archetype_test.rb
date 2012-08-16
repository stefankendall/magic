require 'test_helper'

class CardArchetypeTest < ActiveSupport::TestCase
  test "names for archetypes must be unique" do
    CardArchetype.create(name: "Birds of Paradise2")
    assert_false CardArchetype.new(name: "Birds of Paradise2").save()
  end

  test "A card archetype can be created with rules" do
    CardArchetype.create(name: "SuperForest", rules: [Rule.find_by_name("Forest"), Rule.find_by_name("Land"), Rule.find_by_name("Basic")])
  end
end
