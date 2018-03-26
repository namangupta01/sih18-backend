class Dam < ApplicationRecord
	has_many :users
	has_many :notifications
	has_many :directories
	has_many :dam_water_releases
	def to_s
		name_of_dam
	end
end
