class User < ApplicationRecord
	has_many :user_session_tokens
	has_many :user_locations
	has_many :help_mes
	has_one :notification_delivered
	belongs_to :dam
	has_many :notification_delivereds
	validates :phone_number, uniqueness: true
	validates :phone_number, :password, presence: true
end
