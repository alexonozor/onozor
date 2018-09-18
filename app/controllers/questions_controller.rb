
class QuestionsController < ApplicationController
   
   before_action :set_question, only: [:show, :answers, :comments, :question_voters, :update, :destroy]
   skip_before_action :restrict_access, only: [:index, :show, :answers, :comments, :hots_questions]

   require 'will_paginate/array'
   
    def index
      if is_token_present?
        restrict_access
        feeds = current_user.category_feeds.paginate(page: params[:page], per_page: params[:per_page])
        unless feeds.empty?
          render json: feeds, meta: pagination_dict(feeds), each_serializer: FeedSerializer
        else
          feeds =  Question.paginate(page: params[:page], per_page: params[:per_page])
          render json: feeds, meta: pagination_dict(feeds), each_serializer: FeedSerializer
        end
      else
        feeds =  Question.paginate(page: params[:page], per_page: params[:per_page])
        render json: feeds, meta: pagination_dict(feeds), each_serializer: FeedSerializer
      end
    end

    def comments
      comments = @question.comments.paginate(page: params[:page], per_page: 1)
      render json: comments, meta: pagination_dict(comments)
    end

    def answers
      answers = @question.answers.paginate :page => params[:page], :per_page => 2
      render json: answers, meta: pagination_dict(answers)
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

   def vote
    # ProfileProgress.update_profile_for_upvoted_content(current_user) unless current_user.have_upvoted_a_content?
    vote = QuestionVote.where(question_id: params[:id], user_id: current_user.id ).update_or_create(value: params[:value], question_id: params[:id], user_id: current_user.id)
    if vote
      render json: { message: "Thank you for voting.", success: true, staus: 200 }
    else
      render json: { message: "Unable to vote",  success: false, status: 500 }
    end
  end
  
  def hots_questions
    hots_questions = Question.hot
    render json: hots_questions.to_json
  end

   def question_voters
     user = @question.question_voters
     render json: user.to_json
   end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question.update_views! unless @question.user_id == current_user.id  if current_user.present?
    render json: @question
  end

    # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    # @question.tag_list.add(params[:tag_list])
      if @question.save
        # ProfileProgress.update_profile_for_question(current_user) unless current_user.have_asked_a_question?
        render json: {question: @question}
      else
        render json: { error: @question.errors}
    end
  end

  # PATCH/PUT /questions/1.json
  def update
    # @question.tag_list.add(params[:tag_list])
    if @question.update(question_params)
      render json: {data: @question, status: 200}
    else
      render json: {error: @question.errors, status: 501}
    end
  end

 # DELETE /questions/1.json
 def destroy
    @question.destroy
    render json: {message: "Question has been remove", status: 200}
 end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.friendly.find(params[:id])
  end

  def request_header?
    @userToken = request.headers['Authorization'].present?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.permit(:name, :body, :user_id, :views, :answers_count, :permalink,
                                    :answer_id, :tag_list,  :send_mail, :category_id, :counter_cache, :picture)
  end
end