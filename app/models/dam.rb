class Dam < ApplicationRecord
	has_many :users
	has_many :notifications
	def to_s
		name_of_dam
	end
end
