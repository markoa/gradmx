require 'test_helper'

class PresencesControllerTest < ActionController::TestCase

  test "should create presence" do
    login_as :quentin
    assert_difference('Presence.count') do
      e = events(:one)
      post :create, { :event_id => e.id.to_s }
      assert_equal assigns(:presence).event, e
      assert_equal assigns(:presence).user, users(:quentin)
      assert_redirected_to e
    end
  end

  test "should delete presence" do
    #TODO: figure out how to have seed data
    assert true
  end
end
