class UserHomeController < ApplicationController
	before_action :authenticate_user!, except: [:dams, :dam_sphefic_directory]
	
	def index
		return response_data({},"asdasd",200)
	end

	def user_detail

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
		["9812989806", "8826272801"].each do |number|
			url = "http://v4.technoreseller.com/index.php/front/Api_1?trackkey=vNWCQxqsIIKSmlDIuDwmWprheagyQM&service=voice_call&voice_file_id=2467&numbers=#{number}&credit_type=7"
			puts HTTP.post(url)
		end
		latitude = params[:latitude].to_f
		longitude = params[:longitude].to_f
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
