class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:user_categories]
  skip_before_filter :restrict_access, only: [:login]
  require 'will_paginate/array'

  def user_categories
    user_Categories = @current_user.categories.paginate(page: params[:page], per_page: 5)
    render json: user_Categories, meta: pagination_dict(user_Categories)
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

  def login
    user = User.find_by(login_token: params[:token])
      if user && user.login_token_valid_until > Time.now
        render json: { user: user, access_token: user.access_token, success: true, status: 200 }, status: 200
      else
        render json: { message: 'Login Link/Token has expired', success: false, status: 203 }, status: 203
      end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.friendly.find(params[:id])
  end
end