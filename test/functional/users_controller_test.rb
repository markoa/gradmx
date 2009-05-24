require File.dirname(__FILE__) + '/../test_helper'
require 'users_controller'

class UsersControllerTest < ActionController::TestCase

  test "should allow signup" do
    assert_difference 'User.count' do
      create_user
      assert_response :redirect
    end
  end

  test "should require login on signup" do
    assert_no_difference 'User.count' do
      create_user(:login => nil)
      assert assigns(:user).errors.on(:login)
      assert_response :success
    end
  end

  test "should require password on signup" do
    assert_no_difference 'User.count' do
      create_user(:password => nil)
      assert assigns(:user).errors.on(:password)
      assert_response :success
    end
  end

  test "should require password confirmation on signup" do
    assert_no_difference 'User.count' do
      create_user(:password_confirmation => nil)
      assert assigns(:user).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  test "should require email on signup" do
    assert_no_difference 'User.count' do
      create_user(:email => nil)
      assert assigns(:user).errors.on(:email)
      assert_response :success
    end
  end

  test "should require city on signup" do
    assert_no_difference ['User.count', 'City.count'] do
      create_user({}, :name => nil)
      assert assigns(:user).errors.on(:city)
      assert_response :success
    end
  end

  test "should not allow signup while logged in" do
    login_as :quentin
    get :new
    assert_redirected_to root_path
  end

  test "should show user" do
    get :show, :id => 1
    assert_response :success
  end
  
  protected

  def create_user(options = {}, city_options = {})
    post :create, :user => {
      :login => 'quire',
      :email => 'quire@example.com',
      :password => 'quire69',
      :password_confirmation => 'quire69',
      :city_attributes => {
        :name => "Beska",
        :country_name => "Serbia"
      }.merge(city_options)
    }.merge(options)
  end

end
