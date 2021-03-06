class ApplicationController < ActionController::API
    # protect_from_forgery with: :null_session
    include ActionController::Serialization
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :restrict_access
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    # protect_from_forgery with: :null_session
    serialization_scope :current_user
  
    def current_user
      @current_user
    end

    def is_token_present?
      return request.headers['Authorization'].split(' ')[1] != 'null'
    end

    # request.env["HTTP_ACCESS_TOKEN"]
    #filters
    #before_action :suggested_people, :load_users, :last_requested_at
    before_action  :last_requested_at
  
   # before_action :update_notification
    #before_action :configure_devise_permitted_parameters, if: :devise_controller?
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
    # rescue_from  ActionView::Template::Error, with: :no_user_found
    # helper_method :mobile_device?, :suggested_people
  
    # def after_sign_in_path_for(resource)
    #   request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    # end
  
    # def update_notification
    #  if params['notification_id'].present?
    #   notification = Activity.find(params["notification_id"])
    #   notification.update!(:seen => true)
    #  end
    # end
  
    # def is_admin?
    #   (user_signed_in? && current_user.admin?) ? true : false
    # end
    
    # private
    def last_requested_at
      current_user.update_attribute(:last_requested_at,  Time.now) if current_user.present?
    end
  
    # def no_user_found
    #   flash[:error] = "You need to signin before continuing"
    #   redirect_to root_url
    # end
  
    def record_not_found
      render json: "Record not found", status: 404
    end
  
    # def mobile_device?
    #   if session[:mobile_param]
    #      session[:mobile_param] == "1"
    #   else
    #     (request.user_agent =~ /(iPhone|iPod|Android|webOS|Mobile|Opera|BlackBerry|Nokia)/) && (request.user_agent !~ /iPad/)
    #   end
    # end
  
    # def trackable_activity(trackable)
    #   if trackable.class.name == 'Answer'
    #     answers = trackable.class.where(question_id: trackable.question.id)
    #     users = answers.map(&:user).uniq
    #   elsif trackable.commentable.class.name == 'Answer'
    #     answers = trackable.commentable.class.where(question_id: trackable.commentable.question.id)
    #     users = answers.map(&:user).uniq
    #   else
    #     answers = trackable.commentable.answers
    #     users = answers.map(&:user).uniq
    #   end
    #   users.each do |user|
    #     Activity.create!(action: params[:action], trackable: trackable, user_id: user.id ) unless trackable.user.id == user.id
    #   end
    # end
  
    # def prepare_for_mobile
    #   session[:mobile_param] = params[:mobile] if params[:mobile]
    #   request.format = :mobile if mobile_device?
    # end
  
    # rescue_from CanCan::AccessDenied do |exception|
    #   redirect_to root_url, :alert => exception.message
    # end
  
   
  
      # def configure_devise_permitted_parameters
      #   registration_params = [ :avatar, :last_requested_at, :admin, :avatar_file_name, :username, :gender, :first_name, :last_name, :bio, :occupation, :title,
      #                           :intrest , :username, :location, :email, :password, :password_confirmation, :category_ids]
      #   if params[:action] == 'create'
      #     devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(registration_params)}
      #   end
      # end
  
      # def update_resource(resource, params)
      #   resource.update_without_password(params)
      # end
      private
  
    
      def restrict_access
        if request.headers['Authorization'].present?
          authenticate_or_request_with_http_token do |token|
            begin
              jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first
              @current_user_id = jwt_payload['id']
              @current_user = User.find(@current_user_id)
            rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
              head :unauthorized
            end
          end
        end
      end
    
end