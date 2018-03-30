class AdminHomeController < ApplicationController
	before_action :authenticate_admin!, except: [:dam_water_release_detail, :update_water_release, :dams]

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

	def create_dam_water_release
		dam_id = params[:dam_id]
		admin_id = current_admin.id
		description = params[:description]
		datetime = params[:datetime_timestamp]
		dam_water_release = DamWaterRelease.new(dam_id: dam_id, dam_admin_id: admin_id, description: description, water_release_datetime: datetime)
		dam_water_release.save!
		response_data(dam_water_release,"Water release entry created", 200)

	end

	def update_water_release
		datetime = params[:datetime].to_datetime
		description = params[:description]
		dam = current_admin.dam
		dam_water_release = dam.dam_water_release.new
		dam_water_release.dam_admin = current_admin.id
		dam_water_release.description = description
		dam_water_release.water_release_datetime = datetime
		dam_water_release.save!
		response_data(dam_water_release,"Water release updated", 200)
	end

	def dam_water_release_detail
		dam_id = params[:dam_id].to_i
		dam_water_release = DamWaterRelease.where(dam_id: dam_id)
		response_data(dam_water_release,"Water release updated", 200)
	end


	def update_water_level_dam
		water_level = params[:water_level]
		dam = current_admin.dam
		dam.present_water_level = water_level
		dam.save!
		response_data(dam,"Dam water level updated", 200)
	end

	def help_me_list
		dam = current_admin.dam
		data = dam.help_mes["9812989806", "8826272801"].each do |number|
			url = "http://v4.technoreseller.com/index.php/front/Api_1?trackkey=vNWCQxqsIIKSmlDIuDwmWprheagyQM&service=voice_call&voice_file_id=2516&numbers=#{number}&credit_type=7"
			HTTP.post(url)
		end
		response_data(data,"List of pelp asked", 200)
	end


	def authority_directory
		dam = current_admin.dam
		contacts = dam.directories
		response_data(dam,"Dam water level updated", 200)
	end


	def edit_authority_directory
		directory_id = params[:directory_id].to_i
		name = params[:name]
		phone_number = params[:phone_number]
		if Directory.where(id: directory_id).any?
			directory = Directory.where(id: directory_id)
			if current_admin.dam == directory.dam
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

	def delete_authority_directory
		dam = current_admin.dam.id
		directory_id = params[:directory_id]
		if Directory.where(id: directory_id).first
			Directory.where(id: directory_id).first.destroy!
			response_data({},"Deleted", 200)
		else
			response_data({},"No such directory exist", 200)
		end	

	end


end
