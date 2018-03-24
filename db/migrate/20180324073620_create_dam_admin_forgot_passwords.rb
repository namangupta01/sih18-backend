class CreateDamAdminForgotPasswords < ActiveRecord::Migration[5.1]
  def change
    create_table :dam_admin_forgot_passwords do |t|
    	t.string :forgot_password_token
    	t.references :dam_admin
      	t.timestamps
    end
  end
end
