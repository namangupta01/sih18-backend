class CreateAdminSessionTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_session_tokens do |t|
    	t.string :session_token
    	t.references :admin
      	t.timestamps
    end
  end
end
