
require 'test_helper'
require 'presence'

class PresenceTest < ActiveSupport::TestCase

  test "should create presence" do
    p = Presence.new(:user_id => 1, :event_id => 1)
    assert p.new_record?

    assert_difference('Presence.count') do
      p.save
      assert_equal p.user_id, 1
      assert_equal p.event_id, 1
      assert_equal Presence.last, p
      assert_equal Presence.find_by_key(p.key), p

      assert users(:quentin).presences
      assert users(:quentin).presences.include?(p)

      assert events(:one).presences
      assert events(:one).presences.include?(p)
    end
  end

  test "should delete presence" do
    assert_difference('Presence.count', -1) do
      Presence.last.destroy
    end
  end
end
