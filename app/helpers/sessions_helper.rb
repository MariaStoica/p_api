include ActionController::HttpAuthentication::Token
module SessionsHelper
	
	# Logs in the given user.
	def log_in(user)
		session[:user_id] = user.id
	end

	# Returns the current logged-in user (if any).
	def current_user
		if session[:user_id]
			@current_user = User.find(session[:user_id])
		else
			api_key = ApiKey.where(access_token: token_and_options(request)).first
			@current_user = User.find(api_key.user_id) if api_key
		end
	end

	# Returns true if the user is logged in, false otherwise.
	def logged_in?
		!current_user.nil?
	end

	# Logs out the current user.
	def log_out
		# current_user.delete_auth_token # won't work with curl, but html is good
		session.delete(:user_id)
		@current_user = nil
	end

	def admin_logged_in?
		if logged_in?
			if current_user.country_code == "+40" and (current_user.phone_number == "724017240" or current_user.phone_number == "724611356" or current_user.phone_number == "752077604")
				return true
			else
				return false
			end
		end
	end

end
