class User < ApplicationRecord
	has_many :user_session_tokens
	validates :email, uniqueness: { case_sensitive: false }
end
