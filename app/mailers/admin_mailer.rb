class AdminMailer < ApplicationMailer

	def send_admin_details admin, dam
		@name = admin.name
		@email = admin.email
		@password = admin.password
		@dam_name = dam.name_of_dam
		mail(to: @email, subject: 'Welcome Admin! Here are your credentials to manage your website')
	end
end
