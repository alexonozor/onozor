class TagsController < ApplicationController
    respond_to :html, :js, :json
    layout "bootstrap"

    def index
      if params[:tags].present? && params[:tags][:q].present?
        @q = params[:tags][:q]
        @tags = Question.tag_counts_on(:tags).order("tags.id desc").where("tags.name like ?","%#{params[:tags][:q]}%").paginate :page => params[:page], :per_page => 60
      else
        @q = "Search ..."
        @tags = Question.tag_counts_on(:tags).order("tags.id desc").paginate :page => params[:page], :per_page => 60
      end

      respond_to do |format|
        format.html {}
        format.js { render :partial => "list", :locals => { :tags => @tags }}
      end
    end

    def edit
      @tag = Tag.find_by_name(params["id"])
    end

    def update

    end

    def show
      @tag = Tag.find_by_name(params["id"])
      @questions = Question.tagged_with(params[:id])
    end

    def new
      @tag = Tag.new
    end



    def create
      @tag = Tag.new(tag_params)
      if @tag.save
        respond_to do |format|
          format.html { redirect_to @tag, notice: "Tag was created" }
        end
      else
        render "new"
      end
    end

    def tag_params
      params.require(:tag).permit(:name, :banner, :image, :description, :category_id)
    end



end
