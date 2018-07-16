class Api::V1::CommentsController < ApplicationController
  before_action :set_comments, only: [:show, :index]
  # before_action :authenticate_user!
  require 'will_paginate/array'
  def index
    comments = @question.comments.paginate :page => params[:page], :per_page => 2
    render json: comments
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    #@question.update_views! unless @question.user_id == User.second.id  if User.second.present?
    render json: @question
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comments
    @question = Question.friendly.find(params[:question_id])
  end
end