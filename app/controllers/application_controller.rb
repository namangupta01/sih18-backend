class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session


	def user_secure_session_token
		token = SecureRandom.hex
		while UserSessionToken.where(session_token: token).any? do 
			token = SecureRandom.hex
		end
		token
	end

	def admin_secure_session_token
		token = SecureRandom.hex
		while AdminSessionToken.where(session_token: token).any? do 
			token = SecureRandom.hex
		end
		token
	end

	def confirmation_token
		token = SecureRandom.hex
		while User.where(confirmation_token: token).any? do 
			token = SecureRandom.hex
		end
		token
	end
	

	def response_data(data, message, status, error = nil, disabled = false, update = false, params = {})
		result = Hash.new
		result[:data]  = data
		result[:message] = message
		result[:status] = status
		result[:error] = error
		result[:disabled] = disabled
		result[:update] = update
		render json: result, params: params, status: status
	end

	def authenticate_admin!
		admin_session_token = params[:session_token]
		if AdminSessionToken.where(session_token: admin_session_token).any?
			return true
		else
			return response_data({}, "Unauthticated! Please, Login Again!", 401)
		end
	end

	def authenticate_user!
		user_session_token = params[:session_token]
		if UserSessionToken.where(session_token: user_session_token).any?
			return true
		else
			return response_data({}, "Unauthticated! Please, Login Again", 401)
		end
	end

end
