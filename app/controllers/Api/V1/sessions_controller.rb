class Api::V1::SessionsController < ApplicationController
  skip_before_filter :restrict_access, only: [:create]


  def create
    user = User.find_or_create_by!(email: params[:email]) 
    # Here we set unique login token which is valid only for next 15 minutes
    user.update!(login_token: SecureRandom.urlsafe_base64,
                 login_token_valid_until: Time.now + 15.minutes)
    UserMailer.login_link(user).deliver
    render json: { message: 'Login link sended to your email', success: true }, status: 200
  end
end