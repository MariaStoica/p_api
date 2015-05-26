class UsersController < ApplicationController
  before_action :authenticate, except: [:create, :request_sms_for_login]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    @user.verified = false

    password = give_me_pengin_password
    @user.password = password
    @user.password_confirmation = password

    respond_to do |format|
      if @user.save

        #send sms with our own password
        send_message("Greetings from PengIn! Your password is " + password, @user)

        format.json { render :json => {:success=>true, :message=>"User was successfully created.", :id=>@user.id} }
        # TODO: dupa ce creez userul ar trebui sa il si loghez - sa ii dau un token ca raspuns aici la sign up
        # in the Pengin mobile app, use the id passed in the json response to the sign up to identify which user you are verifying the sms
      else
        format.json { render :json => {:success=>false, :message=>"Failed to create user."} }
      end
    end
  end

  def give_me_pengin_password
    return ["SAURON","SMAUG","BILBO","RING","FRODO","MORDOR","THE SHIRE","HOBBIT","FANGORN","ELVEN","THE FORCE","STAR WARS","VADER","DARTH","YODA","SKYWALKER"].sample
  end

  def send_message(message, user)
    @user = user
    twilio_number = '+14845772911'
    @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    if message = @client.account.messages.create(
      :from => twilio_number,
      :to => @user.country_code+@user.phone_number,
      :body => message
    )

      respond_to do |format|
        format.json { render :json => {:success=>true, :message=>"SMS sent."} }
      end
    
    else
    
      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"Could not send SMS."} }
      end

    end
  end

  def request_sms_for_login
    user = User.find_by(phone_number: params[:phone_number], country_code: params[:country_code])

    if user
      password = give_me_pengin_password
      user.update(password: password)
      user.update(password_confirmation: password)

      #send sms with our own password
      send_message("Greetings from PengIn! Your password is " + password, user)
    else
      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"User does not exist. Sign up, perhaps?"} }
      end
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # only the owner can edit his / her profile info
    if current_user.id == @user.id
      respond_to do |format|
        if @user.update(user_params)

          # update the user interests, too
          if params[:user_interests]

            param_interests = []

            # transform the params into integers so they can be compared to the ids
            params[:user_interests].each do |i|
              param_interests << i.to_i
            end

            # puts "INTERESTS PARAMS = " + param_interests.to_s + "\n"

            # get current user_interests
            current_user_interest_ids = current_user.interests.pluck(:id)
            # puts "CURRENT INTERESTS = " + current_user_interest_ids.to_s + "\n"

            # the ids in params list that are not in current list need to be added
            interests_to_add = param_interests - current_user_interest_ids
            # puts "INTERESTS TO ADD = " + interests_to_add.to_s + "\n"

            if interests_to_add.count > 0
              interests_to_add.each do |interest_id|
                UserInterest.create(user_id: current_user.id, interest_id: interest_id)
              end
            end

            # the ids in current list that are not in params list need to be deleted from user_interests
            interests_to_delete = current_user_interest_ids - param_interests
            # puts "INTERESTS TO DELETE = " + interests_to_delete.to_s + "\n"

            if interests_to_delete.count > 0
              interests_to_delete.each do |interest_id|
                u = UserInterest.where(user_id: current_user.id, interest_id: interest_id)
                if u
                  u.first.destroy
                end
              end
            end

            format.html { redirect_to @user, notice: 'User and user interests was successfully updated.' }
            format.json { render :json => {:success=>true, :message=>"User and user interests was successfully updated."} }
          else
            format.html { redirect_to @user, notice: 'User was successfully updated. No user interests detected.' }
            format.json { render :json => {:success=>true, :message=>"User was successfully updated. No user interests detected."} }
          end # end of if params
        else
          format.html { render :edit }
          format.json { render :json => {:success=>false, :message=>"User could not be updated."} }
        end # end of if .update
      end # end of respond
    else
      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"You are not the owner of this profile."} }
      end
    end
  end # end of method update

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { render :json => {:success=>true, :message=>"User was successfully destroyed."} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :country_code, :phone_number, :avatar, :description, :password_digest, :password, :password_confirmation)
    end

end
