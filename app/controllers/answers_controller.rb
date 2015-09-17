class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy, :undo_link]
   respond_to :html, :xml, :mobile
  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.where("question_id = ? and created_at > ?", params[:question_id], Time.at(params[:after].to_i + 1))
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new( :question_id => params[:question_id], :user => current_user)
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = current_user.answers.build(answer_params)
    @answer.request = request
    if @answer.save 
    respond_to do |format|
      format.html { redirect_to @answer.question, :view => "answer-body", :notice => "Thanks for you Answer"}
      format.mobile { redirect_to @answer.question, :notice => "Thanks for you Answer"}
      format.js 
     end      
      else
    respond_to do |format|
        format.html { redirect_to @answer.question, alert: 'Unable to add Answer' }
        format.mobile { redirect_to @answer.question, alert: 'Unable to add Answer' }
        format.js { render 'fail_create.js.erb' }
       end
      end
    end
  

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
      if @answer.update(answer_params)
       respond_to do |format|
        format.html { redirect_to @answer.question, :notice =>"Edited successfully #{undo_link}".html_safe}
         format.js
       end
      else
       respond_to do |format|
        format.html { redirect_to @answer.question, alert: 'Unable to Update' }
         format.js
        end
      end
    end


  def vote
    vote = current_user.answer_votes.new(value: params[:value], answer_id: params[:id])
    if vote.save
     respond_to do |format|
      format.html {redirect_to :back, notice: "Thank you for voting."}
      format.js {render 'vote.js.erb'}
     end
    else
     respond_to do |format|
      format.html { redirect_to :back, alert: "Unable to vote, perhaps you already did."}
      format.js { render 'fail_vote.js.erb' }  
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
   respond_to do |format|
    flash[:notice] = "Comment was remove #{undo_link}".html_safe
   format.html { redirect_to @answer.question}
   format.js
    end
  end
  
  def undo_link
    if can? :revert, :versions
      version = @answer.versions.scoped.last
        view_context.link_to("undo", revert_version_path(version), :method => :post) if can? :revert, version
    end
   end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:body, :question_id, :user_id, :accepted, :body_plain, :send_mail)
    end
end
