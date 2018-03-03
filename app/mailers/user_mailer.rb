class UserMailer < ApplicationMailer
	default from: 'railsproject283@gmail.com'
	def welcome
		byebug
		mail(to: 'naman18996@gmail.com', subject: 'Welcome to My Awesome Site')
	end	

	def send_signup_confirmation_mail token, user
		@con_token = token
		byebug
		mail(to: user.email, subject: 'Verify your mail')

	end
end
