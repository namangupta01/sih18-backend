class CreateAdminForgotPasswords < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_forgot_passwords do |t|
    	t.string :forgot_password_token
    	t.references :admin
      	t.timestamps
    end
  end
end
