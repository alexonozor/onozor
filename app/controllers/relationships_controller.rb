class RelationshipsController < ApplicationController
  before_action :authenticate_user!
   def create
    @user = User.find(params[:relationship][:followed_id])
   if current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to :back, :notice => "Followed Succefully" }
      format.js
    end
   else
    respond_to do |format|
      format.html { redirect_to :back, :notice => "Unable to Follow" }
      format.js  { render 'create.js.erb' }
    end
  end
 end

  def destroy
    @user = Relationship.find(params[:id]).followed
   if current_user.unfollow!(@user)
   respond_to do |format|
      format.html { redirect_to :back, :notice => "Unfollowed" }
      format.js
    end
   else
    respond_to do |format|
      format.html { redirect_to :back, :notice => "Unable to unFollow" }
      format.js  { render 'destroy.js.erb' }
    end
  end
 end

end
