class CommentsController < ApplicationController
  before_action :set_comments, only: [:show, :index]
  before_action :get_comments, only: [:destroy, :update]
  # before_action :authenticate_user!
  require 'will_paginate/array'
  def index
    comments = @question.comments.paginate(page: params[:page], per_page: 3)
    render json: comments
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    #@question.update_views! unless @question.user_id == User.second.id  if User.second.present?
    render json: @question
  end

  def destroy
    @comment.destroy
    render json: { status: 200, message: 'comment has been deleted', success: true }
  end

  def create
    comment = Comment.new(comment_params)
    comment.user = current_user
      if comment.save
        send_notification(comment)
        render json: { data: comment, status: 200, success: true }, include: 'user'
      else
        render json: { error: comment.errors, status: 500, success: false }
      end
  end

   # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    if @comment.update(comment_params)
      render json: { data: @comment, status: 200, success: true }, include: 'user'
    else
      render json: { error: @comment.errors, status: 500, success: false }
    end
  end

  def send_notification(comment)
    if comment.commentable.class.name == 'Answer'
      answers = comment.commentable.class.where(question_id: comment.commentable.question.id)
      uniq_users = answers.map(&:user).uniq
    else
      answers = comment.commentable.answers
      users = answers.map(&:user)
      users << comment.commentable.user
      uniq_users = users.uniq
    end
    uniq_users.each do |uniq_user|
      Activity.create!(
        action: params[:action], 
        trackable: comment, 
        user_id: uniq_user.id, 
        actor_id: current_user.id
      ) unless uniq_user.id == current_user.id
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comments
    @question = Question.friendly.find(params[:question_id])
  end

  def get_comments
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.permit(:body, :user_id, :commentable_id, :commentable_type, :user_agent, :user_ip, :referrer)
  end
end