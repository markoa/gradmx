require 'test_helper'

class CityTest < ActiveSupport::TestCase

  test "parse" do
    assert_equal City.parse("beska"), cities(:beska)
    assert_equal City.parse("beška"), cities(:beska)
    assert_equal City.parse("Beška"), cities(:beska)
    assert_equal City.parse("Novi sad"), cities(:novisad)
    assert City.parse("Sombor").new_record?
  end
end
