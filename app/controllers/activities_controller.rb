class ActivitiesController < ApplicationController
 def index
  sleep 2
  @activities = Activity.order('created_at DESC')
 end
end
