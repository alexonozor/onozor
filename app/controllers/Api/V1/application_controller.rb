class ApplicationController < ActionController::API
    # protect_from_forgery with: :null_session
    include ActionController::Serialization



    private

  
    def restrict_access
      # binding.pry
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