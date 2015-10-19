class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :vote, :undo_link]
  before_action :authenticate_user!, only: [:edit, :new, :create, :vote ]
  respond_to :html, :xml, :json, :js, :mobile



  require 'will_paginate/array'
  # GET /questions
  # GET /questions.json
  def index
      if (params[:tag].present?)
        @questions = Question.latest.tagged_with(params[:tag]).paginate :page => params[:page], :per_page => 8
      elsif (params[:search].present?)
        @questions = Question.search(params[:search]).paginate(:per_page => 5, :page => params[:page])
      elsif current_user
        @questions = current_user.category_feeds.paginate :page => params[:page], :per_page => 8
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
    @questions = Question.paginate :page => params[:page], :per_page => 8
     respond_to do |format|
        format.xml
        format.html { render :index_for_latest }
        format.js { render 'index.js.erb' }
      end
  end

  def hot
    @questions = Question.hot.paginate :page => params[:page], :per_page => 8
    respond_to do |format|
        format.xml
        format.html { render :index_for_hot }
        format.js { render 'index.js.erb' }
      end
  end

  def active
    @questions = Question.active.paginate :page => params[:page], :per_page => 8
    respond_to do |format|
        format.xml
        format.html { render :index_for_active }
        format.js { render 'index.js.erb' }
      end
  end

  def unanswered
    @questions = Question.unanswered.paginate :page => params[:page], :per_page => 8
    respond_to do |format|
        format.xml
        format.html { render :index_for_unanswered }
        format.js { render 'index.js.erb' }
      end
  end

  def answered
    @questions = Question.answered.paginate :page => params[:page], :per_page => 8
    respond_to do |format|
        format.xml
        format.html { render :index_for_answered }
        format.js { render 'index.js.erb' }
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
      format.mobile {render layout: "application"}
     end
  end

  # GET /questions/new
  def new
    @question = Question.new
    # @tags = Question.tag_counts_on(:tags)

    param =  params[:question] ||= ""
    convert = param["name"]
    @similar_question =  Question.search(convert)
    # require 'pry'; binding.pry
    respond_to do |format|
      format.xml
      format.json
      format.js
      format.mobile { render :layout => "application" }
    end
  end

  # GET /questions/1/edit
  def edit
  @related_questions = @question.find_related_tags.limit(10)
  # authorize! :edit, @questions
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user = current_user
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
        format.html { redirect_to :back, alert: "You can't vote twice."}
        format.js {render 'fail_vote.js.erb'}
        format.mobile { render 'vote.js.erb' }
      end
    end

  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
      if @question.update(question_params)
        redirect_to @question, :notice =>"Question was successfully updated"
      else
        render action: 'edit'
      end
     # authorize! :read, @update
  end


  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    redirect_to root_path, :notice => "Question has been remove #{undo_link}".html_safe
    authorize! :destroy, @questions
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.friendly.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
 def question_params
  params.require(:question).permit(:name, :body, :user_id, :views, :answers_count, :permalink,
                                   :answer_id, :tag_list,  :send_mail, :category_id, :counter_cache)
 end



end
