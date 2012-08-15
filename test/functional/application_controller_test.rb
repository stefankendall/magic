require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  test "created_at and updated_at are not present in the GET game response at all" do
    application_controller = ApplicationController.new
    example_object = {:id => 1, :created_at => "35", :inner => {:id => 2, :updated_at => '33'}}
    returned_json = application_controller.to_json_hash_without_dates(example_object)
    assert_no_date_fields_in_hash returned_json
  end

  test "ensure hash.except! works as expected" do
    hash = {:id => 1, :other => 3, :other2 => 4}
    hash.except! :other, :other2
    assert_false hash.has_key? :other
    assert_false hash.has_key? :other2
  end
end
