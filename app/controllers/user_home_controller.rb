class UserHomeController < ApplicationController
	before_action :authenticate_user!
	
	def index
		return response_data({},"asdasd",200)
	end

end
