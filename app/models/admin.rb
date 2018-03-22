class Admin < ApplicationRecord
	has_many :admin_session_tokens
	belongs_to :dam
end
