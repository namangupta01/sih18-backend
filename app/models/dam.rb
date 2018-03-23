class Dam < ApplicationRecord
	has_many :users
	def to_s
		name_of_dam
	end
end
