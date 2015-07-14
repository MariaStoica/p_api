class SessionsController < ApplicationController

  def new
  end

  def create
    
    user = User.find_by(phone_number: params[:session][:phone_number], country_code: params[:session][:country_code])
    # existing_acc_token = ApiKey.find_by(user_id: user.id)

    # if user
    #   puts "user_id = " + user.id.to_s
      
    #   existing_acc_token = ApiKey.find_by(user_id: user.id)

    #   if existing_acc_token
    #   puts "acc_token = " + existing_acc_token.to_s
    #   else
    #     puts "no acc_token"
    #   end

    #   if user.password_digest
    #     puts "password_digest = " + user.password_digest.to_s
    #   else
    #     puts "no password_digest"
    #   end

    # else
    #   puts "user not found"
    # end

    if user

      if user.authenticate(params[:session][:password]) 

        existing_acc_token = ApiKey.find_by(user_id: user.id)

        if !existing_acc_token
        
          log_in user # nu cred ca log_in user il seteaza si pe current user pt ca... n-au legatura
          # add its access token - expiration and token are created automatically (see the Api_key model)
          
          ApiKey.create(user_id: current_user.id) # if it already exists, it will just rollback the transaction and proceed
          
          current_user.update(verified: true)
          
          # after the first login, no one can then get the acc_token by introducing the one time password
          # if there is an acc_token in the database, invalid any attemtp to get it by password
          # dc pierde aplicatia acc_tokenul, nu poate sa mai logheze vreodata pt ca tre mai intai sa dea logout si apoi sa request a new acc_token

          respond_to do |format|
            format.html { redirect_to database_path(:acc_token => ApiKey.find_by(user_id: current_user.id).access_token.to_s), notice: 'The user has been logged in.'}
            format.json { render :json => {:success=>true, :message=>"The user has been logged in", :acc_token => ApiKey.find_by_user_id(current_user.id).access_token, :id => current_user.id} }
          end

        else
          respond_to do |format|
            format.html { redirect_to login_path, notice: 'Acc_token already exists.'}
            format.json { render :json => {:success=>false, :message=>"Acc_token already exists. You can't use the same password to auth a second time. Logout and login again."} }
          end        
        end
      
      else

        respond_to do |format|
          format.html { redirect_to login_path, notice: 'Invalid phone/password combination'}
          format.json { render :json => {:success=>false, :message=>"Invalid phone/password combination"} }
        end
      
      end

    else
      respond_to do |format|
        format.html { redirect_to login_path, notice: 'No such user'}
        format.json { render :json => {:success=>false, :message=>"No such user"} }
      end  
    end

  end # end of method



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
              format.html { redirect_to root_path }
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
            # format.html { redirect_to login_path }
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
        # format.html { redirect_to login_path }
        format.json { render :json => {:success=>false, :message=>"Logout failed - no acc_token in params"} }
      end
    end

  end # end of destroy







end
