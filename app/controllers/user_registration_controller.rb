class UserRegistrationController < ApplicationController
	def sign_up
		byebug
		user = User.new
		user.email = params[:email]
		user.password = params[:password]
		user.name = params[:name]
		user.phone_number = params[:phone_number]
		user.save!
		return response_data(user,"Signed Up! Please confirm your mail",200)
	end

	def login
		user = User.where(email: params[:email]).first
		if user
			if user.password == params[:password]
				user_session_token = user.user_session_token.new
				user_session_token.session_token = secure_session_token
				user_session_token.save!
			end
		else
			response_data({},"Unauthorized! Wrong id or password",401)
		end

	end
end

