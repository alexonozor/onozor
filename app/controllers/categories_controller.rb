class CategoriesController < ApplicationController
before_action :set_category, only: [:get_questions, :show]
skip_before_action :restrict_access

  require 'will_paginate/array'

  def index
    restrict_access if is_token_present? 
    if params[:term]
      categories = Category.search(params[:term])
      render json: categories
    else
      categories = Category.paginate(page: params[:page], per_page: 9)
      render json: categories, meta: pagination_dict(categories)
    end
  end

  def get_questions
    restrict_access if is_token_present? 
    category_questions = @categories.questions.paginate(page: params[:page], per_page: 5)
    render json: category_questions, each_serializer: FeedSerializer,  meta: pagination_dict(category_questions)
  end

  def show
    restrict_access if is_token_present? 
    render json: @categories
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @categories = Category.friendly.find(params[:id])
  end
end