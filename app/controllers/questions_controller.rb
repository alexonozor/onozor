class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :vote, :undo_link]
  before_action :authenticate_user!, only: [:edit, :new, :create, :vote ]
  layout "display", only: [ :new]
  respond_to :html, :xml, :json, :js, :mobile
  # GET /questions
  # GET /questions.json
  def index
      if (params[:tag].present?)
        @questions = Question.latest.tagged_with(params[:tag]).paginate :page => params[:page], :per_page => 8
      elsif current_user.present? && current_user.only_follower_feed == true
        @questions = current_user.feed.paginate :page => params[:page], :per_page => 8
      else
        @questions = Question.where('id > ?', params[:after].to_i).latest.paginate :page => params[:page], :per_page => 8
      end
      respond_to do |format|
        format.xml
        format.html
        format.js
        format.json
      end 
     
  end

  def latest
    @questions = Question.latest.paginate :page => params[:page], :per_page => 8
     respond_to do |format|
        format.xml
        format.html { render :index_for_latest }
        format.js { render 'index.js.erb' }
      end
  end

  def hot
    @questions = Question.latest.hot.paginate :page => params[:page], :per_page => 8
    respond_to do |format|
        format.xml
        format.html { render :index_for_hot }
        format.js { render 'index.js.erb' }
      end
  end

  def active
    @questions = Question.latest.active.paginate :page => params[:page], :per_page => 8
    respond_to do |format|
        format.xml
        format.html { render :index_for_active }
        format.js { render 'index.js.erb' }
      end
  end

  def unanswered
    @questions = Question.latest.unanswered.paginate :page => params[:page], :per_page => 8
    respond_to do |format|
        format.xml
        format.html { render :index_for_unanswered }
        format.js { render 'index.js.erb' }
      end
  end

  def answered
    @questions = Question.latest.answered.paginate :page => params[:page], :per_page => 8
    respond_to do |format|
        format.xml
        format.html { render :index_for_answered }
        format.js { render 'index.js.erb' }
      end
  end

 def overflowed
    @questions = Question.latest.overflowed.paginate :page => params[:page], :per_page => 8
    respond_to do |format|
        format.xml
        format.html { render :index_for_overflowed }
        format.js { render 'index.js.erb' }
      end
 end


  def advise

    respond_to do |format|
      format.xml
      format.mobile { render :layout => "application" }
    end
  end




  # GET /questions/1
  # GET /questions/1.json
  def show
  @related_questions = @question.find_related_tags.limit(10)
  @question.update_views! unless @question.user_id == current_user.id  if current_user.present?
  @answer = Answer.new(:question => @question, :user => current_user)
  @comment = Comment.new(:commentable_type => @question.class.name, :commentable_id => @question.id, :user => current_user )
  respond_to do |format|
    format.html {render layout: "display"}
    format.mobile {render layout: "application"}
   end
  end

  # GET /questions/new
  def new
    @question = Question.new
    @tags = Question.tag_counts_on(:tags)
    respond_to do |format|
      format.xml
      format.json
      format.mobile { render :layout => "application" }
    end
  end

  # GET /questions/1/edit
  def edit
  @related_questions = @question.find_related_tags.limit(10)
  authorize! :edit, @questions
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    puts  params[:tag_list]
    @question.tag_list.add(params[:tag_list])
      if @question.save
       redirect_to @question,  :notice => "Question was successfully created."
      else
       render action: 'new' 
    end
      authorize! :create, @question
  end

  def vote
    vote = current_user.question_votes.new(value: params[:value], question_id: params[:id] )
    if vote.save
      respond_to do |format|
        format.xml
        format.html { redirect_to :back, notice: "Thank you for voting." }
        format.js { render 'vote.js.erb' }
        format.json
        format.mobile { render 'vote.js.erb' }
      end   
    else
      respond_to do |format|
        format.xml
        format.html { redirect_to :back, alert: "Unable to vote, perhaps you already did."}
        format.js {render 'fail_vote.js.erb'}
        format.mobile { render 'vote.js.erb' }
      end 
    end
    
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
      if @question.update(question_params)
        redirect_to @question, :notice =>"Question was successfully updated. #{undo_link}".html_safe 
      else
        render action: 'edit'
      end
     authorize! :read, @update
  end
  

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    redirect_to :back, :notice=> "Question has been remove #{undo_link}".html_safe 
   authorize! :destroy, @questions 
  end

   def undo_link
    if can? :revert, :versions
      version = @question.versions.scoped.last
        view_context.link_to("undo", revert_version_path(version), :method => :post) if can? :revert, version
    end
   end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.friendly.find(params[:id])  
    end

    # Never trust parameters from the scary internet, only allow the white list through.
 def question_params
  params.require(:question).permit(:name, :body, :user_id, :views, :answers_count, :permalink,
                                   :answer_id, :tag_list,  :send_mail, :category_id)
 end

 

end
