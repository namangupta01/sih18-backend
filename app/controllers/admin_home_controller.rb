class AdminHomeController < ApplicationController
	before_action :authenticate_admin!

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


	def update_dam
		water_level = params[:water_level]
		dam = current_admin_user.dam
		dam.present_water_level = water_level
		dam.save!
		response_data(dam,"Dam water level updated", 200)
	end

	def help_me_list
		dam = current_admin_user.dam
		data = dam.help_me_list
		response_data(data,"List of pelp asked", 200)
	end


	def authority_directory
		dam = current_admin_user.dam
		contacts = dam.directories
		response_data(dam,"Dam water level updated", 200)
	end


	def edit_authority_directory
		directory_id = params[:directory_id].to_i
		name = params[:name]
		phone_number = params[:phone_number]
		if Directory.where(id: directory_id).any?
			directory = Directory.where(id: directory_id)
			if current_admin_user.dam == directory.dam
				directory.name = name
				directory.phone_number = phone_number
				directory.save!
				response_data(directory,"Directory Updated", 200)
			else
				response_data(directory,"Failed to update. Directory donot belongs to this Dam", 400)
			end
		else
			response_data(directory,"No such directory exist", 401)
		end

	end

	def create_authority_directory
		name = params[:name]
		phone_number = params[:phone_number]
		directory = dam.directory.create
		directory.name = name
		directory.phone_number = phone_number
		directory.save!
		response_data(directory,"Another contact in directory created", 200)
	end

end
