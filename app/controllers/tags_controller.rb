class TagsController < ApplicationController
    respond_to :html, :js, :json
    layout "display"

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
        format.json { render :json => @tags.map { |tag| tag.name}.to_json }
        format.mobile { render :layout => "application" }
      end
    end

end

