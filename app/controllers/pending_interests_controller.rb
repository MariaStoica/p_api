class PendingInterestsController < ApplicationController
  before_action :authenticate, except: [:create_interest_from_pending, :destroy]
  before_action :auth_us_PengIn, only: [:create_interest_from_pending, :destroy]
  before_action :set_pending_interest, only: [:show, :destroy, :create_interest_from_pending]

  def index
    @pending_interests = PendingInterest.all
  end

  def show
  end

  def new
    @pending_interest = PendingInterest.new
  end

  def create_interest_from_pending
    if @pending_interest and @pending_interest.name
      Interest.create(name: @pending_interest.name, category_id: nil)
      @pending_interest.destroy
    else
      respond_to do |format|
        format.html { redirect_to database_path, notice: 'Pending interest could not be moved.'}
        format.json { render :json => {:success=>false, :message=>"Pending interest could not be moved."} }
      end
    end
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
    # if current_user.country_code == "+40" and (current_user.phone_number == "724017240" or current_user.phone_number == "724611356" or current_user.phone_number == "752077604")
      @pending_interest.destroy
      respond_to do |format|
        format.html { redirect_to database_path, notice: 'Interest added successfully.'}
        format.json { render :json => {:success=>true, :message=>"Pending interest was successfully destroyed."} }
      end
    # else
    #   respond_to do |format|
    #     format.json { render :json => {:success=>false, :message=>"You are not allowed to delete this pending interest."} }
    #   end
    # end
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
