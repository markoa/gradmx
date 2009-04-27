require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "name constraint" do
    loc = Location.create(:name => "FTN", :city => cities(:novisad))
    assert loc.valid?
    loc = Location.create(:name => "ftn", :city => cities(:novisad))
    assert !loc.valid?
    assert loc.errors.on(:name)
  end
end
