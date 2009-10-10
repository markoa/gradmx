require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should render home page" do
    get :index
    assert_response :success
    assert_select '#highlights', true
  end
end
