class CreateDamAdminSessionTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :dam_admin_session_tokens do |t|
    	t.string :session_token
    	t.references :dam_admin
      	t.timestamps
    end
  end
end
