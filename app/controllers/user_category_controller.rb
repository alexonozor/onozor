class UserCategoryController < ApplicationController
  def create
    @category = current_user.user_categories.create(category_id: params['category_id'].to_i)
    respond_to do |format|
      format.js { render "create.js.erb" }
    end
  end
end
