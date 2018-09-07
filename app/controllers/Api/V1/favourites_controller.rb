class Api::V1::FavouritesController < ApplicationController

  helper UsersHelper
  # GET /favourites
  # GET /favourites.json
  def index
    @user = User.find params[:user_id]
    @questions = @user.favourite_questions.paginate :page => params[:page], :per_page => 25
    render "/users/favourites", :layout => true
  end

  def toggle
    favourite = Favourite.find_by_user_id_and_question_id(@current_user.id, params[:id])
    question = Question.find params[:id]
      if favourite.blank?
        favourite = Favourite.new({:question => question, :user => @current_user})
        favourite.save
          # Activity.create!(action: params[:action], trackable: favourite, user_id:  question.user.id ) if question.user.id != @current_user.id
          render json: { data: favourite, message: 'added!', satus: 201, success: true  }
      else
        favourite.destroy
        render json: { data: favourite, message: 'removed!', satus: 202, success: true  }
      end
  end




    # Never trust parameters from the scary internet, only allow the white list through.
    def favourite_params
      params.require(:favourite).permit(:user_id, :question_id)
    end
end
