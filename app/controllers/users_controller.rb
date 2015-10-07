class UsersController < ApplicationController
  #load_and_authorize_resource
  layout "display", only: [:index, :show]
  respond_to :html, :xml, :json, :js, :mobile
  before_filter :load_users


  def index
   if params[:search].present?
      @user = User.search(params[:search])
    else
     @user = User.order(:username).paginate :page => params[:page], :per_page => 20
   end
  respond_to do |format|
      format.js {}
      format.html { render :index }
      format.mobile { render :layout => "application" }
    end
  end





  def show
    @related_questions = Question.latest.limit(10)
    @user = User.friendly.find(params[:id])
    @user.count_view! unless current_user == @user
    respond_to do |format|
      format.js {}
      format.mobile { render :layout => "application" }
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

  private
  def load_user
    @user = User.order(:username)
  end


  def user_params
    # pry.binding
    params.require(:user).permit(:banned_at, {:category_ids => []},
    :avatar, :last_requested_at, :admin, :avatar_file_name, :username, :gender, :first_name, :last_name, :bio, :occupation, :title,
                            :intrest, :username, :location, :email, :password, :password_confirmation)
  end


end
