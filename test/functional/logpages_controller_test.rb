require 'test_helper'

class LogpagesControllerTest < ActionController::TestCase
  setup do
    @logpage = logpages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logpages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logpage" do
    assert_difference('Logpage.count') do
      post :create, logpage: { category_id: @logpage.category_id, content: @logpage.content, logbook_id: @logpage.logbook_id, title: @logpage.title }
    end

    assert_redirected_to logpage_path(assigns(:logpage))
  end

  test "should show logpage" do
    get :show, id: @logpage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logpage
    assert_response :success
  end

  test "should update logpage" do
    put :update, id: @logpage, logpage: { category_id: @logpage.category_id, content: @logpage.content, logbook_id: @logpage.logbook_id, title: @logpage.title }
    assert_redirected_to logpage_path(assigns(:logpage))
  end

  test "should destroy logpage" do
    assert_difference('Logpage.count', -1) do
      delete :destroy, id: @logpage
    end

    assert_redirected_to logpages_path
  end
end
