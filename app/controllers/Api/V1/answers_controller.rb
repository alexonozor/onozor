class Api::V1::AnswersController < ApplicationController
  before_action :set_answers, only: [:show, :comments, :update]
  # before_action :authenticate_user!
  require 'will_paginate/array'
  # def index
  #   answers = @question.answers.paginate :page => params[:page], :per_page => 5
  #   render json: answers
  # end

  def comments
    @comments = @answer.comments.paginate :page => params[:page], :per_page => 1
    render json: @comments, meta: pagination_dict(@comments)
  end

  def pagination_dict(collection)
    {
        current_page: collection.current_page,
        next_page: collection.next_page,
        prev_page: collection.previous_page, # use collection.previous_page when using will_paginate
        total_pages: collection.total_pages,
        total_count: collection.total_entries
    }
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    #@question.update_views! unless @question.user_id == User.second.id  if User.second.present?
    render json: @question
  end


  def destroy
    answer = Answer.find(params[:id])
    answer.destroy
    render json: { status: 200, message: "Answer has be deleted", success: true }
  end

  def create
    answer = User.first.answers.build(answer_params)
    answer.request = request
    if answer.save
      #  send_notification(@answer)
        render json: answer
    else
      render json: { errors: answer.errors, status: 500, success: false }
    end
  end

   # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: { errors: @answer.errors, status: 500, success: false }
    end
  end

  def send_notification(answer)
    answers = Answer.where(question_id: answer.question.id)
    users = answers.map(&:user) << answer.question.user
    users.uniq.each do |user|
      Activity.create!(action: params[:action], trackable: answer, user_id: user.id ) unless answer.user.id == user.id
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_answers
    @answer = Answer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.permit(:body, :question_id, :user_id, :accepted, :body_plain, :send_mail)
  end
end