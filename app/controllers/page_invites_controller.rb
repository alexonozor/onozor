class PageInvitesController < ApplicationController
  def create
    @page_invite = PageInvite.new(page_id: params[:page_id], invitee_id: params[:invitee_id], inviter_id: params[:inviter_id])
    page = Page.find(params[:page_id])
    if @page_invite.save
      send_notification(@page_invite, page)
      respond_to do |format|
        format.js
        format.html  { redirect_to :back, notice: 'Invited!!' }
      end
    end
  end

  def send_notification(page_invite, page)
    Activity.create!(action: params[:action], trackable: page_invite, user_id: page_invite.invitee_id)
  end

  private
  def page_params
    params.require(:page_user).permit(:user_id, :page_id)
  end
end
