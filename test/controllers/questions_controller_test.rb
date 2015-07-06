require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @question = questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      post :create, question: { answer_id: @question.answer_id, answers_count: @question.answers_count, body: @question.body, name: @question.name, permalink: @question.permalink, send_mail: @question.send_mail, user_id: @question.user_id, views: @question.views }
    end

    assert_redirected_to question_path(assigns(:question))
  end

  test "should show question" do
    get :show, id: @question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question
    assert_response :success
  end

  test "should update question" do
    patch :update, id: @question, question: { answer_id: @question.answer_id, answers_count: @question.answers_count, body: @question.body, name: @question.name, permalink: @question.permalink, send_mail: @question.send_mail, user_id: @question.user_id, views: @question.views }
    assert_redirected_to question_path(assigns(:question))
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete :destroy, id: @question
    end

    assert_redirected_to questions_path
  end
end
