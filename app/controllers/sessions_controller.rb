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
    # logging in through api calls doesn't create a current_user or a session[:user_id]. that's why you need the access token 
    # so... when you make api calls based on the auth_token (which actually tells you who is requesting) you should set current_user based on the acc_token provided
    # params.permit(:acc_token, :phone_number)
    # puts 'params = ' + params.to_s


    if params[:acc_token]
      # if params[:phone_number]
        if ApiKey.find_by_access_token(params[:acc_token])
          # if params[:phone_number] == User.find( ApiKey.find_by_access_token(params[:acc_token]).user_id ).phone_number
            ApiKey.find_by_access_token(params[:acc_token]).destroy
            log_out 

            respond_to do |format|
              format.html { redirect_to login_path }
              format.json { render :json => {:success=>true, :message=>"The user has been logged out"} }
            end
        
          # else # if params phone_number == ce nr are userul
          #   respond_to do |format|
          #     format.html { redirect_to login_path }
          #     format.json { render :json => {:success=>false, :message=>"Logout failed - phone_number and acc_token are not from the same user"} }
          #   end
          # end

        else # if ApiKey are acc_tokenul pasat
          respond_to do |format|
            format.html { redirect_to login_path }
            format.json { render :json => {:success=>false, :message=>"Logout failed - no acc_token found in db"} }
          end        
        end

      # else # if params phone_number
      #   respond_to do |format|
      #     format.html { redirect_to login_path }
      #     format.json { render :json => {:success=>false, :message=>"Logout failed - no phone_number in params"} }
      #   end  
      # end
    else # if params acc_token
      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { render :json => {:success=>false, :message=>"Logout failed - no acc_token in params"} }
      end
    end

  end # end of destroy

end
