require 'test_helper'

class ContinentsControllerTest < ActionController::TestCase
  setup do
    @continent = continents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:continents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create continent" do
    assert_difference('Continent.count') do
      post :create, continent: { name: @continent.name }
    end

    assert_redirected_to continent_path(assigns(:continent))
  end

  test "should show continent" do
    get :show, id: @continent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @continent
    assert_response :success
  end

  test "should update continent" do
    put :update, id: @continent, continent: { name: @continent.name }
    assert_redirected_to continent_path(assigns(:continent))
  end

  test "should destroy continent" do
    assert_difference('Continent.count', -1) do
      delete :destroy, id: @continent
    end

    assert_redirected_to continents_path
  end
end
