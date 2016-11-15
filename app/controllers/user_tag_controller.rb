class UserTagController < ApplicationController

  def create
    @init_tag = Tag.find(params['tag'].to_i)
    @tag = UserTag.new(tag_id: params['tag'].to_i, user_id: params['user'])
    if @tag.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render "fail.js.erb" }
      end
    end
  end

  def destroy
    @init_tag = Tag.find(params[:id].to_i)
    @userTag = UserTag.where(user_id: current_user.id, tag_id: params[:id]).first
    @userTag.destroy
    respond_to do |format|
      format.js
    end
  end
end
