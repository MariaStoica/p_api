class PendingInterestsController < ApplicationController
  before_action :authenticate
  before_action :set_pending_interest, only: [:show, :destroy]

  def index
    @pending_interests = PendingInterest.all
  end

  def show
  end

  def new
    @pending_interest = PendingInterest.new
  end

  def create
    if current_user

        @pending_interest = PendingInterest.new(pending_interest_params)
        @pending_interest.user_id = current_user.id

        respond_to do |format|
          if @pending_interest.save
            format.json { render :show, status: :created, location: @pending_interest }
          else
            format.json { render json: @pending_interest.errors, status: :unprocessable_entity }
          end
        end
    else
      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"Something's wrong with the token. current_user is nil."} }
      end
    end
  end

  def destroy
    # only us, the PengIn admins can destroy pending interests
    if current_user.id == 25 and current_user.phone_number == '724017240'
      @pending_interest.destroy
      respond_to do |format|
        format.json { render :json => {:success=>true, :message=>"Pending interest was successfully destroyed."} }
      end
    else
      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"You are not allowed to delete this pending interest."} }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pending_interest
      @pending_interest = PendingInterest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pending_interest_params
      params.require(:pending_interest).permit(:name)
    end

end
