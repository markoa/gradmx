require 'test_helper'

class LocationsControllerTest < ActionController::TestCase

  test "should get a location" do
    get :show, { :id => 1 }
    assert_response :success
  end

  test "should not be allowed to publish as guest" do
    get :new
    assert_redirected_to :controller => "session", :action => "new"
  end

  test "should be able to publish" do
    login_as :quentin
    get :new
    assert_response :success
  end

  test "should create a location" do
    login_as :quentin
    assert_difference 'Location.count' do
      create_location
      assert_redirected_to location_path(assigns(:location))
    end
  end

  test "should not create a location with empty name" do
    login_as :quentin
    assert_no_difference 'Location.count' do
      create_location(:options => { :name => nil })
      assert assigns(:location).errors.on(:name)
      assert_response :success
    end
  end

  test "should not create a location with empty city" do
    login_as :quentin
    assert_no_difference 'Location.count' do
      create_location(:city_options => { :name => nil })
      assert assigns(:location).errors.on(:city)
      assert_response :success
    end
  end

  test "should not create duplicate location" do
    login_as :quentin
    assert_no_difference 'Location.count' do
      create_location(:options => { :name => "crni bik" },
                      :city_options => { :name => "novi sad", :country_name => "Serbia" })
      assert assigns(:location).errors.on(:name)
      assert_response :success
    end
  end

  protected

  def create_location(args = {})
    options = args[:options] ||= {}
    city_options = args[:city_options] ||= {}

    post :create, "location" => {
      "name" => "Some place",
      "city_attributes" => {
        "name" => "Istanbul",
        "country_name" => "Turkey"
      }.merge(city_options),
      "description" => "Very very short"
    }.merge(options)
  end

end
