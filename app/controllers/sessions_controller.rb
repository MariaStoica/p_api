class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(phone_number: params[:session][:phone_number].downcase)
    if user && user.authenticate(params[:session][:password])
      # login current user
      puts "user = " + user.id.to_s
      log_in user # nu cred ca log_in user il seteaza si pe current user pt ca... n-au legatura
      # add its access token - expiration and token are created automatically (see the Api_key model)
      ApiKey.create(user_id: current_user.id) # if it already exists, it will just rollback the transaction and proceed
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render :json => {:success=>true, :message=>"The user has been logged in", :acc_token => ApiKey.find_by_user_id(current_user.id).access_token, :id => current_user.id} }
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { render :json => {:success=>false, :message=>"Invalid email/password combination"} }
      end
    end
  end

  def destroy
    # current_user.delete_auth_token
    # delete the token from the Api_keys table
    ApiKey.find_by_user_id(current_user.id).destroy
    # log out
    log_out
    redirect_to login_path
  end
end
