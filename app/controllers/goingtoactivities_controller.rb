class GoingtoactivitiesController < ApplicationController
  before_action :set_goingtoactivity, only: [:show, :edit, :update, :destroy]

  # GET /goingtoactivities
  # GET /goingtoactivities.json
  def index
    @goingtoactivities = Goingtoactivity.all
  end

  # GET /goingtoactivities/1
  # GET /goingtoactivities/1.json
  def show
  end

  # GET /goingtoactivities/new
  def new
    @goingtoactivity = Goingtoactivity.new
  end

  # GET /goingtoactivities/1/edit
  def edit
  end

  # POST /goingtoactivities
  # POST /goingtoactivities.json
  def create
    @goingtoactivity = Goingtoactivity.new(goingtoactivity_params)

    respond_to do |format|
      if @goingtoactivity.save
        format.html { redirect_to @goingtoactivity, notice: 'Goingtoactivity was successfully created.' }
        format.json { render :show, status: :created, location: @goingtoactivity }
      else
        format.html { render :new }
        format.json { render json: @goingtoactivity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goingtoactivities/1
  # PATCH/PUT /goingtoactivities/1.json
  def update
    respond_to do |format|
      if @goingtoactivity.update(goingtoactivity_params)
        format.html { redirect_to @goingtoactivity, notice: 'Goingtoactivity was successfully updated.' }
        format.json { render :show, status: :ok, location: @goingtoactivity }
      else
        format.html { render :edit }
        format.json { render json: @goingtoactivity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goingtoactivities/1
  # DELETE /goingtoactivities/1.json
  def destroy
    @goingtoactivity.destroy
    respond_to do |format|
      format.html { redirect_to goingtoactivities_url, notice: 'Goingtoactivity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goingtoactivity
      @goingtoactivity = Goingtoactivity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goingtoactivity_params
      params.require(:goingtoactivity).permit(:user_id, :activity_id)
    end
end
