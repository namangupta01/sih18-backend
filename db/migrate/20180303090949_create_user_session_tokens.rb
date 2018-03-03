class CreateUserSessionTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :user_session_tokens do |t|
    	t.string :session_token
    	t.references :user
      	t.timestamps
    end
  end
end
