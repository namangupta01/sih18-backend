class AdminRegistrationController < ApplicationController
	def login
		admin = Admin.where(email: params[:email]).first
		if admin
			if admin.password = params[:password]
				session_token = secure_token
				data = Hash.new
				data[:user] = user
				data[:token] = session_token
				return response_data(data, "Login Successful!", 200)
			end
		else 
			return response_data({}, "Wrong Login id or password", 401)
		end
	end
end
