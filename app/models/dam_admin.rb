class DamAdmin < ApplicationRecord
	has_many :dam_admin_session_tokens
	belongs_to :dam
	has_many :dam_water_releases
	after_create :send_details
	has_one :dam_admin_forgot_password

	# validates :password, :dam_id, :name, presence: true

	# validates :email, uniqueness: true, presence: true

	def send_details
		AdminMailer.send_admin_details(self, dam).deliver_later
	end
end
