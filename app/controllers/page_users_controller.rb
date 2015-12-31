class PageUsersController < ApplicationController
  respond_to :html
  def create
    @pageUser = current_user.page_users.build(page_id: params[:page_id])
    @pageUser.save
    redirect_to :back, notice: 'liked!'
  end

  def destroy
    @pageUser = PageUsers.find_by(user_id: current_user.id, page_id: params[:page_id])
    @pageUser.destroy
    redirect_to :back, notice: 'unlike!'
  end

  private
  def page_params
    params.require(:page_user).permit(:user_id, :page_id)
  end
end
