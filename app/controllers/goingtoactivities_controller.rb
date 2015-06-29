class GoingtoactivitiesController < ApplicationController
  before_action :authenticate
  before_action :set_goingtoactivity, only: [:show, :edit, :update, :destroy]

  # GET /goingtoactivities
  # GET /goingtoactivities.json
  def index
    @goingtoactivities = Goingtoactivity.all
  end

  # GET /goingtoactivities/1
  # GET /goingtoactivities/1.json
  # def show
  # end

  # GET /goingtoactivities/new
  def new
    @goingtoactivity = Goingtoactivity.new
  end

  # GET /goingtoactivities/1/edit
  # def edit
  # end

  # POST /goingtoactivities
  # POST /goingtoactivities.json
  def create
    # puts "!!! goingtoactivity_params " + goingtoactivity_params.to_s
    # puts "\n"
    # puts "!!! params " + params.to_s
    # !!! goingtoactivity_params {"user_id"=>"1", "activity_id"=>"9"}
    # !!! params {"goingtoactivity"=>{"user_id"=>"1", "activity_id"=>"9"}, "action"=>"create", "controller"=>"goingtoactivities"}

    # only the owner can edit his / her activity
    if current_user.id == goingtoactivity_params[:user_id].to_i
      # params is the same with goingtoactivity params? otherwise could be a crack
      # print goigntoactivity params to see what they look like

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
    else
      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"You are not the owner of this user id."} }
      end
    end
  end

  # PATCH/PUT /goingtoactivities/1
  # PATCH/PUT /goingtoactivities/1.json
  # def update
  #   if current_user.id == @goingtoactivity.user_id
  #     respond_to do |format|
  #       if @goingtoactivity.update(goingtoactivity_params)
  #         format.html { redirect_to @goingtoactivity, notice: 'Goingtoactivity was successfully updated.' }
  #         format.json { render :show, status: :ok, location: @goingtoactivity }
  #       else
  #         format.html { render :edit }
  #         format.json { render json: @goingtoactivity.errors, status: :unprocessable_entity }
  #       end
  #     end
  #   else
  #     respond_to do |format|
  #       format.json { render :json => {:success=>false, :message=>"You are not the owner of this user id."} }
  #     end
  #   end
  # end

  # DELETE /goingtoactivities/1
  # DELETE /goingtoactivities/1.json
  def destroy
    if current_user.id == @goingtoactivity.user_id
      @goingtoactivity.destroy
      respond_to do |format|
        format.json { render :json => {:success=>true, :message=>"Goingtoactivity was successfully destroyed."} }
      end
    else
      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"You are not the owner of this user id."} }
      end
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
