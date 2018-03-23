class AdminRegistrationController < ApplicationController
	before_action :authenticate_admin!, only: [:change_password]



	def login
		admin = Admin.where(email: params[:email]).first
		if admin
			if admin.password = params[:password]
				session_token = admin_secure_session_token
				data = Hash.new
				data[:user] = user
				data[:admin_session_token] = session_token
				return response_data(data, "Login Successful!", 200)
			else
				return response_data({}, "Wrong Login id or password", 401)
			end
		else 
			return response_data({}, "Wrong Login id or password", 401)
		end
	end

	def forgot_password
		phone_number = params[:phone_number]
		if Admin.where(phone_number: phone_number).any?
			admin = Admin.where(phone_number: phone_number)
			otp = get_otp
			message = "Your otp for reset password is #{otp}"
			if AdminForgotPassword.where(admin_id: admin.id).any?
				admin_forgot_password = AdminForgotPassword.where(admin_id: admin.id).first
				admin_forgot_password.forgot_password_token = otp
				admin_forgot_password.save!
			else
				admin_forgot_password = admin.admin_forgot_password.create
				admin_forgot_password.forgot_password_token = otp
				admin_forgot_password.save!
			end
			send_otp(phone_number, message)
			return response_data({}, "Otp sent to the number", 200)
		else
			return response_data({}, "No such phone number exists", 550)
		end
	end


	def reset_password
		phone_number = params[:phone_number]
		otp = params[:otp]
		password = params[:password]
		if Admin.where(phone_number: phone_number).any?
			admin = Admin.where(phone_number: phone_number).first
			if admin.admin_forgot_password.forgot_password_token == otp
				admin.password = password
				admin.save!
				admin.admin_forgot_password.destroy!
				return response_data({}, "Password reset successfully", 200)
			else
				return response_data({}, "OTP donot match!", 400)
		else
			return response_data({}, "Such phone number donot exists", 401)
		end
	end

	def change_password
		password = params[:password]
		current_admin.password = password
		current_admin.save!
			return response_data({}, "Password Changed", 200)
		end
	end

	private

	def get_otp
		otp = rand(100001..999999)
		while AdminForgotPassword.where(forgot_password_token: otp).any?
			otp = rand(100001..999999)
		end
		otp
	end
end
