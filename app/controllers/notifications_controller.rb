class NotificationsController < ApplicationController
    before_action :notification_params, only: [:update, :mark_all]
    before_action :find_notification, only: [:update]
    # skip_before_action :restrict_access
    require 'will_paginate/array'


    def index
        notifications = current_user.activities
        render json: notifications
    end

    def update
      if @notification.update(notification_params)
        render json: { message: 'updated', status: 200, success: true }
      else
        render json: { error: @notification.errors, status: 500, success: false }
      end 
    end

    def notification_count
      notification = current_user.activities.unseen.count
      render json: { notification_count: notification, status: 200, success: true } 
    end

    def mark_all
      current_user.activities.update_all(notification_params)
      render json: { message: 'updated', status: 200, success: true }
    end

private
  def find_notification
    @notification = Activity.find(params[:id])
  end

  def notification_params
    params.permit(:seen, :read, :read_at)
  end
end