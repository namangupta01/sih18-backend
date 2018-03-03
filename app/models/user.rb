class User < ApplicationRecord
	has_many :user_session_tokens
end
