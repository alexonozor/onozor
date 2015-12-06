class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json, :js
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new(comment_params)
  end

  # GET /comments/1/edit
  def edit
   respond_to do |format|
     format.js
   end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
      if @comment.save
        send_notification(@comment)
        @parent = @comment.commentable
     respond_to do |format|
     format.html { redirect_to @parent, :view => "comments", :notice => "Thanks for you comment"}
      format.js {render "create.js.erb"}  
     end      
      else
        respond_to do |format|
          format.js { render "fail_create.js.erb"}
       end   
      end
  end

 def send_notification(comment)
   if comment.commentable.class.name == 'Answer'
     answers = comment.commentable.class.where(question_id: comment.commentable.question.id)
     users = answers.map(&:user).uniq
   else
     answers = comment.commentable.answers
     users = answers.map(&:user).uniq
   end
   users.each do |user|
     Activity.create!(action: params[:action], trackable: comment, user_id: user.id )
   end
 end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
      if @comment.update(comment_params)
       respond_to do |format|
        format.html { redirect_to @comment.question, :notice =>"Edited successfully #{undo_link}".html_safe}
        format.js {render "update.js.erb"}
       end
      else
       respond_to do |format|
        format.html { redirect_to @comment.question, alert: 'Unable to Update' }
        format.js  {render "update_fail.js.erb"}
        end
      end
  end


  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
      format.json { head :no_content }
    end
  end


    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :user_id, :commentable_id, :commentable_type, :user_agent, :user_ip, :referrer)
    end
  end

