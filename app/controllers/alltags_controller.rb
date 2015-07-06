class AlltagsController < ApplicationController
  before_action :set_alltag, only: [:show, :edit, :update, :destroy]

  # GET /alltags
  # GET /alltags.json
  def index
    @alltags = Alltag.where("name Like ?", "%#{params[:q]}%")
    respond_to do |format|
     format.json { render :json => @alltags.map(&:attributes)}
     format.html
   end
  end

  # GET /alltags/1
  # GET /alltags/1.json
  def show
  end

  # GET /alltags/new
  def new
    @alltag = Alltag.new
  end

  # GET /alltags/1/edit
  def edit
  end

  # POST /alltags
  # POST /alltags.json
  def create
    @alltag = Alltag.new(alltag_params)
    respond_to do |format|
      if @alltag.save
        format.html { redirect_to @alltag, notice: 'Alltag was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alltag }
      else
        format.html { render action: 'new' }
        format.json { render json: @alltag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alltags/1
  # PATCH/PUT /alltags/1.json
  def update
    respond_to do |format|
      if @alltag.update(alltag_params)
        format.html { redirect_to @alltag, notice: 'Alltag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @alltag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alltags/1
  # DELETE /alltags/1.json
  def destroy
    @alltag.destroy
    respond_to do |format|
      format.html { redirect_to alltags_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alltag
      @alltag = Alltag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alltag_params
      params.require(:alltag).permit(:name, :description, :user_id, :question_id)
    end
end
