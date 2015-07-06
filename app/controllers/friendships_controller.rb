class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def create
  @friendships = current_user.friendships.build(:friend_id => params[:friend_id])
   if @friendships.save
     redirect_to :back, :notice =>"followed successfully"
    else
     redirect_to :back, :alert => "Unable to follow"
   end
  end

  def destroy
   @friendships = current_user.friendships.find(params[:id])
   @friendships.destroy
   redirect_to :back, :alert => "Unfollow succesfully"
  end
end
