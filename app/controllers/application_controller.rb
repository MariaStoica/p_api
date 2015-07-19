  class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception # null_session
  include SessionsHelper
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  ############################################

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      # make sure each api call has an auth_token attached to it - no annonymous calls allowed
      apikey = ApiKey.find_by_access_token(token)
      
      if apikey
        user_id = apikey.user_id
        user = User.find(user_id)

        if user 
          return true
        else
          respond_to do |format|
            format.json { render :json => {:success=>false, :message=>"Something's wrong with the auth_token. User not found."} }
          end
          return false
        end

      else
        respond_to do |format|
          format.json { render :json => {:success=>false, :message=>"Something's wrong with the auth_token. ApiKey not found."} }
        end
        return false
      end

      # if apikey.expires_at <= Time.now
      #   puts "!!! I'm gonna need to update this here token cause it expired"
      #   apikey.update_access_token 
      #   # and somehow give it to the ios app ?! :D
      # end

    end
  end

  def auth_us_PengIn
    # authenticate_or_request_with_http_token do |token, options|
      apikey = ApiKey.find_by_access_token(params[:acc_token])
      
      if apikey
        user_id = apikey.user_id
        user = User.find(user_id)

        if user 
          if current_user.country_code == "+40" and (current_user.phone_number == "724017240" or current_user.phone_number == "724611356" or current_user.phone_number == "752077604")
            return true
          else
            return false
          end
        else
          respond_to do |format|
            format.html { redirect_to root_path, notice: 'No user.'}
          end
          return false
        end

      else
        respond_to do |format|
          format.json { render :json => {:success=>false, :message=>"Something's wrong with the auth_token. ApiKey not found."} }
        end
        return false
      end

    # end
  end

end
