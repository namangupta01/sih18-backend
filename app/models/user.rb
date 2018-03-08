class User < ApplicationRecord
	has_many :user_session_tokens
	has_many :user_locations
	has_many :help_mes
	validates :email, uniqueness: { case_sensitive: false }
end
