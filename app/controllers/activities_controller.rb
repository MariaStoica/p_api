class ActivitiesController < ApplicationController
  before_action :authenticate
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    if current_user
      @activity = Activity.new(activity_params)
      @activity.user_id = current_user.id

      respond_to do |format|
        if @activity.save

          # add owner to going to activity
          Goingtoactivity.create(user_id: @activity.user_id, activity_id: @activity.id)

          format.json { render :show, status: :created, location: @activity }
        else
          format.json { render json: @activity.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"Something's wrong with the token. current_user is nil."} }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    # only the owner can edit his / her activity
    if current_user.id == @activity.user_id
      respond_to do |format|
        if @activity.update(activity_params)
          format.json { render :json => {:success=>true, :message=>"Activity was successfully updated."} }
        else
          format.json { render :json => {:success=>false, :message=>"Something went wrong. Could not update activity."} }
        end
      end
    else
      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"You are not the owner of this activity."} }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    # only the owner can destroy his / her activity
    if current_user.id == @activity.user_id
      # also delete all goingtoactivities that have this actvity
      Goingtoactivity.where(activity_id: @activity.id).delete_all
      # also delete all comments of that activity
      Comments.where(activity_id: @activity.id).delete_all

      @activity.destroy
      respond_to do |format|
        format.json { render :json => {:success=>true, :message=>"Activity was successfully destroyed."} }
      end
      # TODO: what if the activity wasn't successfully destroyed?
    else
      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"You are not the owner of this activity."} }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:name, :user_id, :location, :time, :nrofpeopleinvited, :description)
    end
end
