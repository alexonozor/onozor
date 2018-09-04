class Api::V1::UserCategoryController < ApplicationController
  def create
    subscription = current_user.user_categories.new(category_id: params['category_id'].to_i)
    if subscription.save
      render json: { message: 'subscribed', status: 200 }
    else
      render json: subscription.errors, status: 501
    end
  end

  def destroy
    subscription = UserCategory.find_by(category_id: params['category_id'], user_id: current_user.id)
    if subscription
      subscription.destroy
      render json: { message: 'unsubscribed', status: 200 }
    else
      render json: { message: 'unable unsubscribed', status: 502 }
    end
  end
end
