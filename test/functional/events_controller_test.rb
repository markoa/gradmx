require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    login_as :quentin
    get :new
    assert_response :success
  end

  test "should not get new as guest" do
    get :new
    assert_redirected_to new_session_path
  end

  test "should create event" do
    login_as :quentin
    assert_difference('Event.count') do
      desc = "some desc"
      create_event(:description => desc)
      assert assigns(:event).description, desc
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should not create event as a spider" do
    assert_no_difference('Event.count') do
      create_event
    end

    assert_redirected_to new_session_path
  end

  test "should show event" do
    assert_difference 'PageView.count' do
      get :show, :id => events(:one).to_param
      assert_response :success
    end
  end

  test "should show event and store PageView with user_id" do
    login_as :quentin
    assert_difference 'PageView.count' do
      get :show, :id => events(:one).to_param
      assert_response :success
      assert_equal assigns(:page_view).user_id, users(:quentin).id
    end
  end

  test "should get edit" do
    login_as :quentin
    get :edit, :id => events(:one).to_param
    assert_response :success
  end

  test "should update event" do
    login_as :quentin
    put :update, :id => events(:one).to_param, :event => { :title => "xyz" }
    assert_equal assigns(:event).title, "xyz"
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    login_as :quentin
    assert_difference('Event.count', -1) do
      delete :destroy, :id => events(:one).to_param
    end

    assert_redirected_to events_path
  end

  protected

  def create_event(options = {})
    day = 2.hours.from_now.utc
    the_end = 4.hours.from_now.utc
    time_begin = options[:time_begin] || day
    time_end = options[:time_end] || the_end

    post :create, :event => {
      "title"=>"Some title",
      "location_id" => locations(:art_klinika).id,
      "description" => "almost blank",
      "time_begin(1i)" => time_begin.year.to_s,
      "time_begin(2i)" => time_begin.month.to_s,
      "time_begin(3i)" => time_begin.day.to_s,
      "time_begin(4i)" => time_begin.hour.to_s,
      "time_begin(5i)" => time_begin.min.to_s,
      "time_end(1i)" => time_end.year.to_s,
      "time_end(2i)" => time_end.month.to_s,
      "time_end(3i)" => time_end.day.to_s,
      "time_end(4i)" => time_end.hour.to_s,
      "time_end(5i)" => time_end.min.to_s
    }
  end

end
