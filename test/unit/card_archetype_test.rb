require 'test_helper'

class CardArchetypeTest < ActiveSupport::TestCase
  test "names for archetypes must be unique" do
    CardArchetype.create(name: "Birds of Paradise")
    assert_false CardArchetype.new(name:"Birds of Paradise").save()
  end
end
