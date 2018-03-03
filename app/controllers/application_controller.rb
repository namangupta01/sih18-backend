class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session


	def secure_token
		token = SecureRandom.hex
		while UserSessionToken.where(session_token: token).any? do 
			token = SecureRandom.hex
		end
		token
	end
	

	def response_data(data, message, status, error: nil, disabled: false, update: false, params: {})
		result = Hash.new
		result[:data]  = data
		result[:message] = message
		result[:status] = status
		result[:error] = error
		result[:disabled] = disabled
		result[:update] = update
		render json: result, params: params, status: status
	end

end
