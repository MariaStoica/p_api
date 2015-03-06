class UserInterestsController < ApplicationController
  before_action :set_user_interest, only: [:show, :edit, :update, :destroy]

  # GET /user_interests
  # GET /user_interests.json
  def index
    @user_interests = UserInterest.all
  end

  # GET /user_interests/1
  # GET /user_interests/1.json
  def show
  end

  # GET /user_interests/new
  def new
    @user_interest = UserInterest.new
  end

  # GET /user_interests/1/edit
  def edit
  end

  # POST /user_interests
  # POST /user_interests.json
  def create
    @user_interest = UserInterest.new(user_interest_params)

    respond_to do |format|
      if @user_interest.save
        format.html { redirect_to @user_interest, notice: 'User interest was successfully created.' }
        format.json { render :show, status: :created, location: @user_interest }
      else
        format.html { render :new }
        format.json { render json: @user_interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_interests/1
  # PATCH/PUT /user_interests/1.json
  def update
    respond_to do |format|
      if @user_interest.update(user_interest_params)
        format.html { redirect_to @user_interest, notice: 'User interest was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_interest }
      else
        format.html { render :edit }
        format.json { render json: @user_interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_interests/1
  # DELETE /user_interests/1.json
  def destroy
    @user_interest.destroy
    respond_to do |format|
      format.html { redirect_to user_interests_url, notice: 'User interest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_interest
      @user_interest = UserInterest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_interest_params
      params.require(:user_interest).permit(:user_id, :interest_id)
    end
end
