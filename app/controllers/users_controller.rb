class UsersController < ApplicationController
  #load_and_authorize_resource 
  layout "display"
  respond_to :html, :xml, :json, :js, :mobile
  before_filter :load_users
  before_filter :load_questions

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

 

  private
  def load_user
  @user = User.order(:username)
  end

  def load_questions
  @related_questions = Question.all
  end
  
  def user_params
      params.require(:user).permit(:banned_at )
  end


end
