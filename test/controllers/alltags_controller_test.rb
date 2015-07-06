require 'test_helper'

class AlltagsControllerTest < ActionController::TestCase
  setup do
    @alltag = alltags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alltags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alltag" do
    assert_difference('Alltag.count') do
      post :create, alltag: { description: @alltag.description, name: @alltag.name, question_id: @alltag.question_id, user_id: @alltag.user_id }
    end

    assert_redirected_to alltag_path(assigns(:alltag))
  end

  test "should show alltag" do
    get :show, id: @alltag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alltag
    assert_response :success
  end

  test "should update alltag" do
    patch :update, id: @alltag, alltag: { description: @alltag.description, name: @alltag.name, question_id: @alltag.question_id, user_id: @alltag.user_id }
    assert_redirected_to alltag_path(assigns(:alltag))
  end

  test "should destroy alltag" do
    assert_difference('Alltag.count', -1) do
      delete :destroy, id: @alltag
    end

    assert_redirected_to alltags_path
  end
end
