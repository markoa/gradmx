require 'test_helper'

class EventTest < ActiveSupport::TestCase

  test "should create event" do
    e = init_event
    assert e.save
    assert_equal e.location, locations(:art_klinika)
    assert locations(:art_klinika).events.include?(e)
  end

  test "should not create event with empty title" do
    e = init_event(:title => nil)
    assert !e.save
  end

  test "should not create event with empty time_begin" do
    e = init_event(:time_begin => nil)
    assert !e.save
  end

  test "should not create event without a location" do
    e = init_event(:location => nil)
    assert !e.save
  end

  test "should not create event with early time_end" do
    e = init_event(:time_end => (Time.now.utc - 1*60*60))
    assert !e.save
    assert e.errors.on(:time_end)
  end

  protected

  def init_event(options = {})
    Event.new({
      :title => "xyz",
      :time_begin => 2.days.from_now.utc,
      :location => locations(:art_klinika),
      :user => users(:quentin)
    }.merge(options))
  end

end
