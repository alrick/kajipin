require 'test_helper'

class AccesstokensControllerTest < ActionController::TestCase
  setup do
    @accesstoken = accesstokens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accesstokens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accesstoken" do
    assert_difference('Accesstoken.count') do
      post :create, accesstoken: { type: @accesstoken.type, user_id: @accesstoken.user_id, value: @accesstoken.value }
    end

    assert_redirected_to accesstoken_path(assigns(:accesstoken))
  end

  test "should show accesstoken" do
    get :show, id: @accesstoken
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accesstoken
    assert_response :success
  end

  test "should update accesstoken" do
    put :update, id: @accesstoken, accesstoken: { type: @accesstoken.type, user_id: @accesstoken.user_id, value: @accesstoken.value }
    assert_redirected_to accesstoken_path(assigns(:accesstoken))
  end

  test "should destroy accesstoken" do
    assert_difference('Accesstoken.count', -1) do
      delete :destroy, id: @accesstoken
    end

    assert_redirected_to accesstokens_path
  end
end
