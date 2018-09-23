class FavouritesController < ApplicationController
  def toggle
    favourite = Favourite.find_by_user_id_and_question_id(@current_user.id, params[:id])
    question = Question.find params[:id]
      if favourite.blank?
        favourite = Favourite.new({:question => question, :user => @current_user})
        favourite.save
          Activity.create!(action: params[:action], trackable: favourite, user_id:  question.user.id, actor_id: @current_user.id ) if question.user.id != @current_user.id
          render json: { data: favourite, message: 'added!', satus: 201, success: true  }
      else
        favourite.destroy
        render json: { data: favourite, message: 'removed!', satus: 202, success: true  }
      end
  end
end
