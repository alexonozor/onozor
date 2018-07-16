class Api::V1::QuestionsController < ApplicationController
   before_action :set_question, only: [:show]
   # before_action :authenticate_user!
   require 'will_paginate/array'
    def index
        @feeds = User.second.category_feeds.paginate(page: params[:page], per_page: 5)
        render json: @feeds, meta: pagination_dict(@feeds), each_serializer: FeedSerializer
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
    @question.update_views! unless @question.user_id == User.second.id  if User.second.present?
    render json: @question
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.friendly.find(params[:id])
  end
end