class RelationshipsController < ApplicationController

     def create
      user = User.find(params[:followed_id])
     if current_user.follow!(user)
        send_notification(user)
        Follower.followers_update(user, current_user).deliver
        render json: { message: "Followed Succefully", status: 200 }
     else
        render json: { message: "Unable to Follow", status: 501 }
      end
   end

   def send_notification(user)
     Activity.create!(action: params[:action], trackable: user, user_id: user.id, actor_id: current_user.id )
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