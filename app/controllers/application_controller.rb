class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #filters

  
  before_filter :last_requested_at
  before_action :load_users
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_filter :prepare_for_mobile
  before_filter :load_category

  def load_category
    @category  = Category.limit(10)
  end

  layout :layout_by_resource



  private
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      (request.user_agent =~ /(iPhone|iPod|Android|webOS|Mobile|Opera|BlackBerry|Nokia)/) && (request.user_agent !~ /iPad/)
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
  
  rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end
 
  private
 
  def record_not_found
    render  "public/404.html", status: 404, layout: false
  end

  protected




 


   def load_users
      @users = User.all
   end
  

  

  protected

  def configure_devise_permitted_parameters
    registration_params = [ :avatar, :last_requested_at, :admin, :avatar_file_name, :username, :gender, :first_name, :last_name, :bio, :occupation, :title, :intrest , :username, :location, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
          |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
          |u| u.permit(registration_params)
      }
    end
  end


 
      def is_admin?
        if user_signed_in? && current_user.admin?
         true
        else
         false
        end
      end




  private
  def last_requested_at
    current_user.update_attribute(:last_requested_at,  Time.now) if current_user.present?
  end

  protected

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == "edit"
     "application"
    end
  end

end
