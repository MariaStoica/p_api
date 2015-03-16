require 'test_helper'

class GoingtoactivitiesControllerTest < ActionController::TestCase
  setup do
    @goingtoactivity = goingtoactivities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goingtoactivities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create goingtoactivity" do
    assert_difference('Goingtoactivity.count') do
      post :create, goingtoactivity: { activity_id: @goingtoactivity.activity_id, user_id: @goingtoactivity.user_id }
    end

    assert_redirected_to goingtoactivity_path(assigns(:goingtoactivity))
  end

  test "should show goingtoactivity" do
    get :show, id: @goingtoactivity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @goingtoactivity
    assert_response :success
  end

  test "should update goingtoactivity" do
    patch :update, id: @goingtoactivity, goingtoactivity: { activity_id: @goingtoactivity.activity_id, user_id: @goingtoactivity.user_id }
    assert_redirected_to goingtoactivity_path(assigns(:goingtoactivity))
  end

  test "should destroy goingtoactivity" do
    assert_difference('Goingtoactivity.count', -1) do
      delete :destroy, id: @goingtoactivity
    end

    assert_redirected_to goingtoactivities_path
  end
end
