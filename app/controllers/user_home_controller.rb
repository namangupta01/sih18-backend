class UserHomeController < ApplicationController
	before_action :authenticate_user!, except: [:dams, :dam_sphefic_directory]
	
	def index
		return response_data({},"asdasd",200)
	end

	def user_detail

	end

	def user_detail
		user_id = params[:user_id]
		if User.where(id: user_id).any?
			user = User.where(id: user_id)
			response_data(user,"Here's the user", 200)
		else
			response_data({},"No such user exist", 400)
		end
	end

	def dams
		if params[:page].nil? || params[:state].nil?
			dams = Dam.all
			response_data(dams,"List of all dams", 200)
		else
			if !params[:page].nil?
				page = params[:page].to_i
				per_page_dams = 20
				offset = per_page_dams * page
				dams = Dam.offset(offset).limit(20)
				response_data(dams,"List of dams pagewise", 200)
			else
				state = params[:state]
				dams = Dam.where('lower(state) = lower(?)', state)
				response_data(dams,"List of dams statewise", 200)
			end
		end	
	end

	def update_user_dam_details
		dam_id = params[:dam_id].to_i
		dam = Dam.where(id: dam_id).first
		if dam
			current_user.dam = dam
			current_user.save!
			response_data(current_user, "Details updated", 200)
		else
			response_data({}, "Wrong dam_id", 400)
		end
	end


	def save_location
		if !params[:latitude].nil? && !params[:longitude].nil?
			latitude = params[:latitude].to_f
			longitude = params[:longitude].to_f
			location = current_user.user_locations.new
			location.latitude = latitude
			location.longitude = longitude
			location.save!
			response_data(location, "Location saved", 200)
		else
			response_data({}, "Bad request", 400)
		end

	end


	def notifications
		latitude = params[:latitude].to_f
		longitude = params[:longitude].to_f
		user_location = current_user.user_locations.new
		user_location.latitude = latitude
		user_location.longitude = longitude
		user_location.save!
		if current_user.notification_delivered
			notification_delivered = current_user.notification_delivered
			time_till_notifications_delivered = notification_delivered.date_time
			dam = current_user.dam
			notifications = Notification.where('created_at > (?)', time_till_notifications_delivered).where(dam_id: dam.id)
		else
			notification_delivered = current_user.notification_delivereds.create
			dam = current_user.dam
			notifications = Notification.where(dam_id: dam.id)
		end
		notification_delivered.date_time = DateTime.current
		notification_delivered.save!
		response_data(notifications, "Notification Polling", 200)
	end

	def all_notifications
		notifications = current_user.dam.notifications
		response_data(notifications, "All notifications", 200)
	end



	def help_me
		latitude = params[:latitude].to_f
		longitude = params[:longitude].to_f
		user = current_user
		user.help = true
		user.save!
		users = get_users
		location = current_user.user_locations.new
		location.latitude = latitude
		location.longitude = longitude
		location.save!

		["9812989806", "8826272801", "9818478695"].each do |number|
			url = "http://v4.technoreseller.com/index.php/front/Api_1?trackkey=vNWCQxqsIIKSmlDIuDwmWprheagyQM&service=voice_call&voice_file_id=2467&numbers=#{number}&credit_type=7"
			puts HTTP.post(url)
		end
		HTTP.get("http://api.msg91.com/api/sendhttp.php?sender=MSGIND&route=4&mobiles=8586825882&authkey=206794A5qFdT6fl5abe16ce&country=91&message=DANGER")
		help_me = current_user.help_mes.new
		help_me.latitude = latitude
		help_me.longitude = longitude
		help_me.dam_id = current_user.dam_id
		help_me.save!
		notification = Notification.create
		notification.message = "Is in danger"
		notification.notification_type = 1
		notification.author = "user"
		notification.dam_id = current_user.dam_id
		notification.resource_id = help_me.id
		notification.save!
		response_data(help_me, "Asked for help from people around you", 200)
	end

	def dam_sphefic_directory
		dam_id = params[:dam_id]
		if Dam.where(id: dam_id).any?
			dam = Dam.where(id: dam_id).first
			contacts = dam.directories
			response_data(contacts,"Dam directory", 200)
		else
			response_data({},"Wrong dam ID", 400)
		end
	end

	def dam_directory
		dam = current_user.dam
		contacts = dam.directories
		response_data(contacts,"Dam directory", 200)
	end


	def get_list_who_need_help
		latitude = params[:latitude].to_f
		longitude = params[:longitude].to_f
		users = User.where(help: true)
		user_array = []
		if users.any?
			users = users - current_user
			users.each do |user|
				user_location = user.user_locations.last
				distance = Haversine.distance(latitude, longitude, user_location.latitude, user_location.longitude).to_m
				if distance < 500
					data = Hash.new
					data["user"] = user
					data["latitude"] = user_location.latitude
					data["longitude"] = user_location.longitude
					user_array << data
				end
			end
		end
		response_data(user_array, "List given", 200)
	end

	def get_nearby_people
		latitude = params[:latitude].to_f
		longitude = params[:longitude].to_f
		users = User.where(help: false)
		users = users - current_user
		user_array = []
		if users.any?
			users.each do |user|
				user_location = user.user_locations.last
				distance = Haversine.distance(latitude, longitude, user_location.latitude, user_location.longitude).to_m
				if distance < 500
					data = Hash.new
					data["user"] = user
					data["latitude"] = user_location.latitude
					data["longitude"] = user_location.longitude
					user_array << data
				end
			end
		end
		response_data(user_array, "List given", 200)
	end

	def create_user_personal_directory
		name = params[:name]
		description = params[:description]
		phone_number = params[:phone_number]
		user_personal_directory = current_user.user_personal_directories.new
		user_personal_directory.name = name
		user_personal_directory.description = description
		user_personal_directory.phone_number = phone_number


	end

	def update_user_personal_directory


	end

	def edit_user_personal_directory


	end

	def user_personal_directory_detail


	end


	def help_status
		status = current_user.help
		response_data(status,"help status", 200)
	end

	private

	def get_users



	end

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
