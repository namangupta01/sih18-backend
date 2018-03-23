class UserRegistrationController < ApplicationController

	def sign_up
		user = User.new
		user.email = params[:email]
		user.password = params[:password]
		user.name = params[:name]
		user.phone_number = params[:phone_number]
		user.dam_id= params[:dam_id]
		token = confirmation_token
		user.confirmation_token = token
		if user.save
			UserMailer.send_signup_confirmation_mail(token, user).deliver_now
			return response_data(user,"Signed Up! Please confirm your mail",201)
		else 
			return response_data({}, "Something Went wrong", 409, user.errors.full_messages )
		end
	end

	def login
		user = User.where(email: params[:email]).first
		if user
			if  user.confirmed
				if user.password == params[:password]
					user_session_token = user.user_session_tokens.new
					user_session_token.session_token = user_secure_session_token
					user_session_token.save!
					data = Hash.new
					data[:token] = user_session_token.session_token
					response_data(data, "Successfully! Login", 200)
				end
			else
				response_data({},"Verify your mail",401)
			end
		else
			response_data({},"Unauthorized! Wrong id or password",401)
		end
	end


	# def verify_signup_otp
	# 	user = User.where(otp: params[:otp])
	# 	if user.any?
	# 		user = user.first
	# 		user.otp = nil
	# 		user.confirmed = true
	# 		user.save!
	# 		response_data({}, "Otp matched successfully", 200)
	# 	else
	# 		response_data({}, "Otp doesn't match", 401)
	# 	end
	# end

	def verify_confirmation_mail
		token = params[:confirmation_token]
		user = User.where(confirmation_token: token)
		@status = false
		if user.any?
			user = user.first
			user.confirmed = true
			user.confirmation_token = nil
			user.save!
			@status = true
		end
	end
end

