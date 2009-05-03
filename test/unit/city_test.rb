require 'test_helper'

class CityTest < ActiveSupport::TestCase

  test "parse" do
    assert_equal City.parse("beska", "Serbia"), cities(:beska)
    assert_equal City.parse("beška", "Serbia"), cities(:beska)
    assert_equal City.parse("Beška", "Serbia"), cities(:beska)
    assert_equal City.parse("Novi sad", "Serbia"), cities(:novisad)
    assert City.parse("Sombor", "Serbia").new_record?
  end
end
