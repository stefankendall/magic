ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def assert_no_date_fields_in_hash(hash)
    hash.each do |k, v|
      assert_not_equal 'created_at', k, hash
      assert_not_equal 'updated_at', k, hash
      if v.class == Hash
        assert_no_date_fields_in_hash(v)
      end
      if v.class == Array
        v.each do |element|
          if element.class == Hash
            assert_no_date_fields_in_hash(element)
          end
        end
      end
    end
  end
end
