class FavouritesController < ApplicationController

  helper UsersHelper
  # GET /favourites
  # GET /favourites.json
  def index
    @user = User.find params[:user_id]
    @questions = @user.favourite_questions.paginate :page => params[:page], :per_page => 25
    render "/users/favourites", :layout => true
  end

  def toggle
    @favourite = Favourite.find_by_user_id_and_question_id(current_user.id, params[:id])
    @question = Question.find params[:id]
    respond_to do |format|
      if @favourite.blank?
        @message = "favorited!"
        @class = "favourite-saved"
        @favourite = Favourite.new({:question => @question, :user => current_user})
        @favourite.save
      else
        @message = "Remove as your favourite"
        @class = "favoured"
        @favourite.destroy
      end
      flash[:notice] = @message
      format.js { }
      format.mobile {render "favourites/toggle.js.erb"}
      format.html { redirect_to :back }
    end
  end




    # Never trust parameters from the scary internet, only allow the white list through.
    def favourite_params
      params.require(:favourite).permit(:user_id, :question_id)
    end
end
