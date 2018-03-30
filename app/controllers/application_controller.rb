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
		while DamAdminSessionToken.where(session_token: token).any? do 
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
		admin_session_token = params[:admin_session_token]
		if DamAdminSessionToken.where(session_token: admin_session_token).any?
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

	def current_user
		UserSessionToken.where(session_token: params[:session_token]).first.user
	end

	def current_admin
		DamAdminSessionToken.where(session_token: params[:admin_session_token]).first.dam_admin
	end

	def send_otp phone_number, message
		url = "http://api.msg91.com/api/sendhttp.php?sender=BVPTEH&route=4&mobiles=#{phone_number}
							&authkey=#{Rails.application.config.auth_key}&country=0&message=#{message}"
		HTTP.get(url)
	end

end
