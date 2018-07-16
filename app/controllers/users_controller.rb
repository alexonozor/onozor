class UsersController < ApplicationController

  #load_and_authorize_resource
  layout "display", only: [:index, :show, :edit]
  # before_filter :load_users
  # before_filter :get_user, only: [:show,
  #                                 :show_user_questions,
  #                                 :show_user_answers,
  #                                 :show_user_followers,
  #                                 :show_user_following,
  #                                 :show_user_favorites]

  def index
   if params[:search].present?
      @user = User.search(params[:search])
    else
     @users = User.order(:username)
   end
  respond_to do |format|
      format.js {}
      format.html { render :index }
    end
  end

  def show
    @related_questions = Question.limit(10)
    @new_message = @user.direct_messages.new if @user
    @user.count_view! unless current_user == @user
    respond_to do |format|
      format.js {}
      format.html
      format.json { render json: @user }
    end
  end



  def show_user_questions
    @user_questions = @user.questions
    respond_to do |format|
      format.js {render "filter_by_user_questions.js"}
    end
  end

  def show_user_answers
    @user_answers = @user.answered_questions
    respond_to do |format|
      format.js {render "filter_by_user_answers.js"}
    end
  end

  def show_user_followers
    @users = @user.followers.order("updated_at ASC")
    @title = "Followers"
    respond_to do |format|
      format.js {render "filter_by_follows.js"}
    end
  end

  def show_user_following
    @users = @user.followed_users.order("updated_at ASC")
    @title = "Following"
    respond_to do |format|
      format.js {render "filter_by_follows.js"}
    end
  end


  def show_user_favorites
    @user_favorited_questions = @user.favourite_questions
    respond_to do |format|
      format.js {render "filter_by_favorites.js"}
    end
  end

  def ban
    @user = User.find(params[:id])
    authorize! :ban, :user
    @user.update_attribute(:banned_at, Time.now)
    @answers = @user.answers
    @answers.each(&:destroy)
    respond_to do |format|
      format.html { redirect_to :back, :notice => "User #{@user.username} has been banned." }
      format.js
    end
  end


  def who_is_online
    @users = User.online
    respond_to do |format|
      format.js {}
      format.mobile { render :layout => "application" }
    end
  end

  def user_categories
    if current_user
      @user_categories = Category.all.where.not(id: current_user.categories.all.map {|a| a.id})
      respond_to do |format|
        format.json { render :json => @user_categories.to_json  }
      end
    end
  end



  def select_category
   if current_user.update(user_params)
     @people_to_follows = User.people_you_may_know(current_user)
     respond_to do |format|
       format.js { render "user_select_category.js", layout: false, content_type: 'text/javascript'  }
       format.html {redirect_to root_path}
     end
   else
     respond_to do |format|
       format.html {redirect_to root_path}
     end
   end
  end

  def update
   @user = current_user
  if @user.update(user_params)
    ProfileProgress.update_profile_for_bio_updated(@user) unless @user.bio_changed? && @user.changed?
      redirect_to root_path, notice: "Account was updated successfully"
   else
     redirect_to :back
   end
  end

  def edit
     @user = current_user
  end

  def edit_user
    @option = params[:option]
    respond_to do |format|
      format.js { render "show_edit_box.js" }
    end if @option
  end

  def update_user
    @option = (user_params && user_params[:option]) ? user_params[:option] : nil
    update_user_info if @option
    respond_to do |format|
      format.js { render "update_user.js", layout: false, content_type: 'text/javascript' }
    end
  end


  private

  def load_user
    @user = User.order(:username)
  end

  def user_params
    params.require(:user).permit(:banned_at, {:category_ids => []},
    :avatar, :last_requested_at, :admin, :avatar_file_name, :username, :gender, :first_name, :last_name, :bio, :occupation, :title,
                            :intrest, :username, :location, :email, :password, :password_confirmation, :option, :fullname, :city, :country,
                            :twitter_url, :facebook_url, :personal_website, :cover_photo) if params.has_key? "user"
  end

  def update_user_info
    if @option == "fullname"
      user_fullname
    else
      @current_user[@option] = user_params[@option]
    end
    @current_user.save
  end

  def user_fullname
    fullname = user_params[@option].split(" ")
    @current_user.first_name = fullname[0]
    @current_user.last_name = fullname[1]
  end

  def get_user
    @user = User.friendly.find(params[:id])
  end
end
