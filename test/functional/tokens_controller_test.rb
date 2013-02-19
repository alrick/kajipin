require 'test_helper'

class TokensControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Token.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Token.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Token.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to token_url(assigns(:token))
  end

  def test_edit
    get :edit, :id => Token.first
    assert_template 'edit'
  end

  def test_update_invalid
    Token.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Token.first
    assert_template 'edit'
  end

  def test_update_valid
    Token.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Token.first
    assert_redirected_to token_url(assigns(:token))
  end

  def test_destroy
    token = Token.first
    delete :destroy, :id => token
    assert_redirected_to tokens_url
    assert !Token.exists?(token.id)
  end
end
