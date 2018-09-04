class Api::V1::RelationshipsController < ApplicationController

     def create
      user = User.find(params[:followed_id])
     if current_user.follow!(user)
        # Follower.followers_update(user, current_user).deliver
        render json: { message: "Followed Succefully", status: 200 }
     else
        render json: { message: "Unable to Follow", status: 501 }
      end
   end
  
    def destroy
      user = current_user.relationships.find_by(followed_id: params[:id]).followed
     if current_user.unfollow!(user)
      render json: { message: "Unfollowed", status: 200 }
     else
      render json: { message: "Unable to unfollow", status: 501 }
    end
   end
  
  end