class Api::V1::AnswersController < ApplicationController
  before_action :set_answers, only: [:show, :index]
  # before_action :authenticate_user!
  require 'will_paginate/array'
  def index
    answers = @question.answers.paginate :page => params[:page], :per_page => 5
    render json: answers
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    #@question.update_views! unless @question.user_id == User.second.id  if User.second.present?
    render json: @question
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_answers
    @question = Question.friendly.find(params[:question_id])
  end
end