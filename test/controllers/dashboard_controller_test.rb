require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get account" do
    get :account
    assert_response :success
  end

  test "should get billing" do
    get :billing
    assert_response :success
  end

  test "should get messages" do
    get :messages
    assert_response :success
  end

  test "should get overview" do
    get :overview
    assert_response :success
  end

end
