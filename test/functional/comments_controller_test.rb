require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  test "should not create a new comment when not logged in" do
    assert_no_difference('Comment.count') do
      create_comment
      assert_redirected_to new_session_path
    end
  end

  test "should create a new comment" do
    login_as :quentin
    assert_difference('Comment.count') do
      create_comment
      assert_equal assigns(:comment).user, users(:quentin)
      assert_redirected_to events(:one)
    end
  end

  test "should not create a new comment with blank bodu" do
    login_as :quentin
    assert_no_difference('Comment.count') do
      create_comment(:body => nil)
      assert_redirected_to events(:one)
    end
  end

  protected

  def create_comment(options = {})
    post :create, :event_id => events(:one), :comment => {
      :body => "something witty"
    }.merge(options)
  end
end
