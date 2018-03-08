class UserHomeController < ApplicationController
	before_action :authenticate_user!
	
	def index
		return response_data({},"asdasd",200)
	end

	def dams
		byebug
		dams = Dam.all
		response_data(dams,"List of all dams", 200)
	end


	def notifications
		latitude = params[:latitude]
		longitude = params[:longitude]
		user_location = current_user.user_locations.new
		user_location.latitude = latitude
		user_location.longitude = longitude
		user_location.save!
		response_data({}, "Notification Polling", 200)
	end

	def help_me
		latitude = params[:latitude].to_i
		longitude = params[:longitude].to_i
		help_me = current_user.help_mes.new
		help_me.latitude = latitude
		help_me.longitude = longitude
		geocoder=GoogleGeocoder.reverse_geocode([latitude,longitude])
		help_me.address = geocoder.full_address
		help_me.save!
		response_data({}, "Asked for help from people around you", 200)
	end

	private

	def user_alert
		past_minutes_help 30




	end

	def past_minutes_help mins
		help_mes = HelpMe.where('created_at >= (?)', 2.minutes.ago)
		help_mes.each do |help_me|


		end
		distance = find_distance 

	end

	def find_distance


	end


end
