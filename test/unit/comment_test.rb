require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "presence of body" do
    c = Comment.new(:user_id => 1, :event_id => 1, :body => '')
    assert !c.save
    assert c.errors.on(:body)
  end

  test "user checking" do
    c = Comment.new(:event_id => 1, :body => 'great stuff')
    assert !c.save
    assert c.errors.on(:user_id)
  end

  test "should create comment" do
    c = users(:quentin).comments.build(:event_id => 1, :body => "trlala")
    assert c.save
    assert_equal c.user, users(:quentin)
  end
end
