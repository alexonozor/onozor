class UsersController < ApplicationController
  #load_and_authorize_resource
  layout "display", only: [:index, :show]
  respond_to :html, :xml, :json, :js, :mobile
  before_filter :load_users
  before_filter :get_user, only: [:show,
                                  :show_user_questions,
                                  :show_user_answers,
                                  :show_user_followers,
                                  :show_user_following,
                                  :show_user_favorites]

  def index
   if params[:search].present?
      @user = User.search(params[:search])
    else
     @users = User.order(:username).paginate :page => params[:page], :per_page => 20
   end
  respond_to do |format|
      format.js {}
      format.html { render :index }
      format.mobile { render :layout => "application" }
    end
  end

  def show
    @related_questions = Question.limit(10)
    @new_message = @user.direct_messages.new if @user
    @user.count_view! unless current_user == @user
    respond_to do |format|
      format.js {}
      format.mobile { render :layout => "application" }
    end
  end

  def show_user_questions
    @user_questions = @user.questions.order("created_at ASC").limit(10)
    respond_to do |format|
      format.js {render "filter_by_user_questions.js"}
    end
  end

  def show_user_answers
    @user_answers = @user.answers.order("updated_at ASC").limit(10)
    respond_to do |format|
      format.js {render "filter_by_user_answers.js"}
    end
  end

  def show_user_followers
    @users = @user.followers.order("updated_at ASC").limit(20)
    @title = "Followers"
    respond_to do |format|
      format.js {render "filter_by_follows.js"}
    end
  end

  def show_user_following
    @user_questions = @user.followed_users.order("updated_at ASC").limit(20)
    @title = "Following"
    respond_to do |format|
      format.js {render "filter_by_follows.js"}
    end
  end


  def show_user_favorites
    @user_favorited_questions = @user.favourites.order("updated_at ASC").limit(20)
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

  def select_category
   if current_user.update(user_params)
     respond_to do |format|
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
      format.js { render "update_user.js" }
    end
  end

  private

  def load_user
    @user = User.order(:username)
  end


  def user_params
    # pry.binding
    params.require(:user).permit(:banned_at, {:category_ids => []},
    :avatar, :last_requested_at, :admin, :avatar_file_name, :username, :gender, :first_name, :last_name, :bio, :occupation, :title,
                            :intrest, :username, :location, :email, :password, :password_confirmation, :option, :fullname) if params.has_key? "user"
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
