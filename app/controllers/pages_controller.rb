class PagesController < ApplicationController
  layout "display"
  before_action :set_page, only: [:show, :edit,
                                  :update, :destroy,
                                  :upload_page_logo,
                                  :upload_page_cover_picture,
                                  :invite_friends]
  impressionist :actions=>[:show]
  respond_to :html
  helper_method :current_page

  def index
    @pages = Page.all
    respond_with(@pages)
  end

  def show
    @questions = @page.questions
    respond_with(@page)
  end

  def new
    @pageType = PageType.all
    @page = Page.new
    respond_with(@page)
  end

  def edit
  end

  def invitess
    @page = Page.find(params[:page_id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @page = Page.new(page_params)
    @page.user_id = current_user.id if current_user
    flash[:notice] = 'Page was successfully created.' if @page.save
    redirect_to invite_friends_page_path(@page)
  end

  def update
    flash[:notice] = 'Page was successfully updated.' if @page.update(page_params)
    redirect_to invite_friends_page_path(@page)
  end

  def questions
    @question = Question.new(question_parmas)
    @question.user_id = current_user.id if current_user
    if @question.save
      respond_to do |format|
        format.html { redirect_to @question.page, notice: 'Page was successfully created.' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @question.page, notice: 'Page was successfully created.' }
        format.js
      end
    end
  end

  def answer
   @question = Question.find(params['question']['question_id'])
   @answer = Answer.new(question_id: @question.id, user_id: current_user.id)
     respond_to do |format|
      format.js {'answer.js.erb'}
     end
  end

  def create_answer
    @question = Question.find(params['answer']['question_id'])
    @answer = Answer.new(answer_parmas)
    if @answer.save
      respond_to do |format|
        format.js   { render 'create_answer'}
        format.html { redirect_to :back, anchor: "answer_#{@answer.id}" }
      end
    else
      respond_to do |format|
        format.js { render 'create_answer'}
      end
    end
  end

  def edit_question
    @question = Question.find(params[:id])
    respond_to do |format|
      format.js { render 'edit_question' }
    end
  end

  def update_question
    @question = Question.find(params[:id])
    if @question.update_attributes(question_parmas)
      respond_to do |format|
        format.js { render 'update_question' }
      end
    end
  end

  def upload_page_logo
    if @page.update(page_params)
      respond_to do |format|
        format.js
      end
    end
  end

  def upload_page_cover_picture
    if @page.update(page_params)
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @page.destroy
    respond_with(@page)
  end

  private
    def set_page
      @page = Page.find(params[:id])
    end

    def question_parmas
      params.require(:question).permit(:name, :questionable_type, :body, :picture, :page_id, :category_id)
    end

    def answer_parmas
      params.require(:answer).permit(:body, :user_id, :question_id)
    end

    def page_params
      params.require(:page).permit(:name, :address, :zip_code, :phone, :privacy_id, :website, :long_description, :short_description, :cover_picture, :logo, :user_id, :page_type_id)
    end
end
