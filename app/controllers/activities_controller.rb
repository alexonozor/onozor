class ActivitiesController < ApplicationController
  before_action :authenticate_user!
 def index
  @activities = Activity.order('created_at DESC')
 end

 def destroy
  @activity = Activity.find(params[:id])
  @activity.destroy
  redirect_to :back
 end
end
