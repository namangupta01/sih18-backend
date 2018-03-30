class AdminRegistrationController < ApplicationController
	before_action :authenticate_admin!, only: [:change_password]



	def login
		admin = DamAdmin.where(email: params[:email]).first
		if admin
			if admin.password = params[:password]
				session_token = admin_secure_session_token
				dam_admin_session_token = admin.dam_admin_session_tokens.new(session_token: session_token)
				dam_admin_session_token.save!
				data = Hash.new
				data[:user] = admin
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
		if DamAdmin.where(phone_number: phone_number).any?
			admin = DamAdmin.where(phone_number: phone_number).first
			otp = get_otp
			message = "Your otp for reset password is #{otp}"
			byebug
			if DamAdminForgotPassword.where(dam_admin_id: admin.id).any?
				admin_forgot_password = DamAdminForgotPassword.where(dam_admin_id: admin.id).first
				admin_forgot_password.forgot_password_token = otp
				admin_forgot_password.save!
			else
				byebug
				admin_forgot_password = admin.dam_admin_forgot_password.new
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
		if DamAdmin.where(phone_number: phone_number).any?
			admin = DamAdmin.where(phone_number: phone_number).first
			if admin.admin_forgot_password.forgot_password_token == otp
				admin.password = password
				admin.save!
				admin.admin_forgot_password.destroy!
				return response_data({}, "Password reset successfully", 200)
			else
				return response_data({}, "OTP donot match!", 400)
			end
		else
			return response_data({}, "Such phone number donot exists", 401)
		end
	end

	def change_password
		dam_admin = current_admin
		password = params[:password]
		dam_admin.password = password
		dam_admin.save!
		return response_data({}, "Password Changed", 200)
	end

	private

	def get_otp
		otp = rand(100001..999999)
		while DamAdminForgotPassword.where(forgot_password_token: otp).any?
			otp = rand(100001..999999)
		end
		otp
	end
end
