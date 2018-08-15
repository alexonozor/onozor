class ApplicationController < ActionController::API
    protect_from_forgery with: :null_session
    include ActionController::Serialization
    
end