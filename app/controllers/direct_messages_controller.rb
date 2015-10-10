class DirectMessagesController < ApplicationController
  def create
    user = User.find_by_username(params[:user_id]) # routing pattern replaces id with username
    if user && user.direct_messages.create(dm_params.merge({created_by: @current_user.username}) )
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end
  end

  def dm_params
    params.require(:direct_message).permit(:title, :body, :user_id)
  end
end
