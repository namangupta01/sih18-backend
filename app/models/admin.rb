class Admin < ApplicationRecord
	has_many :admin_session_tokens
	belongs_to :dam

	after_create :send_details

	# validates :password, :dam_id, :name, presence: true

	# validates :email, uniqueness: true, presence: true

	def send_details
		AdminMailer.send_admin_details(self, dam).deliver_later
	end

end
