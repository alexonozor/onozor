class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:user_categories, :show, :followers, :following, :questions, :answers, :favorites]
  skip_before_filter :restrict_access, only: [:login]
  require 'will_paginate/array'

  def user_categories
    user_Categories = @current_user.categories.paginate(page: params[:page], per_page: 5)
    render json: user_Categories, meta: pagination_dict(user_Categories)
  end

  def index
    users = User.order(:username).paginate(page: params[:page], per_page: 20)
    render json: users, meta: pagination_dict(users), each_serializer: UsersSerializer
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
 
  def update
    user = current_user
   if user.update(user_params)
    user = User.find(current_user.id)
    #  ProfileProgress.update_profile_for_bio_updated(@user) unless @user.bio_changed? && @user.changed?
      render json:  { user: user, status: 200}.to_json
    else
      render json:  { error: user, status: 500}.to_json
    end
   end

 
  def login
    user = User.find_by(login_token: params[:token])
      if user && user.login_token_valid_until > Time.now
        render json: { user: user, access_token: user.access_token, success: true, status: 200 }, status: 200
      else
        render json: { message: 'Login Link/Token has expired', success: false, status: 203 }, status: 203
      end
  end

  def questions
    user_questions = @user.questions.paginate(page: params[:page], per_page: 3)
    render json: user_questions, meta: pagination_dict(user_questions), each_serializer: FeedSerializer
  end

  def answers
    user_answers = @user.answered_questions.paginate(page: params[:page], per_page: 3)
    render json: user_answers, meta: pagination_dict(user_answers), each_serializer: FeedSerializer
  end

  def followers
    users = @user.followers.order("updated_at DESC").paginate(page: params[:page], per_page: 6)
    render json: users, meta: pagination_dict(users), each_serializer: UsersSerializer
  end

  def following
    users = @user.followed_users.order("updated_at DESC").paginate(page: params[:page], per_page: 6)
    render json: users, meta: pagination_dict(users), each_serializer: UsersSerializer
  end

  def favorites
    user_favorited_questions = @user.favourite_questions.paginate(page: params[:page], per_page: 3)
    render json: user_favorited_questions, meta: pagination_dict(user_favorited_questions), each_serializer: FeedSerializer
  end

  def show
   render json: @user
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.permit(:banned_at, {:category_ids => []},
    :avatar, :last_requested_at, :admin, :avatar_file_name, :username, :gender, :first_name, :last_name, :bio, :occupation, :title,
                            :intrest, :username, :location, :email, :password, :password_confirmation, :option, :fullname, :city, :country,
                            :twitter_url, :facebook_url, :personal_website, :cover_photo,
                            :facebook_url, :twitter_url, :person_url)
  end
end